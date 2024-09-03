Attribute VB_Name = "VBT_outpleakage"
Public Function OutputZ_leak_vbt(PatternFile As Pattern, SeqLeakPins As PinList, ForceV_IiL As Double, _
                        waitTime As Double, Init_HiPins As PinList, Init_LoPins As PinList, _
                        Optional I_Meas_Range As Double, Optional Tnames_ As String = "OutputZ_Leak") As Long
    On Error GoTo errHandler
    
Dim Site As Variant
Dim PinArr() As String, PinCount As Long, i As Long
Dim measVal As New PinListData

'''''''Connect all signal pins (digital_pins) to the pin electronics and apply levels'''''''''''
TheHdw.Digital.ApplyLevelsTiming True, True, False, tlPowered, Init_LoPins.Value
TheHdw.PPMU.Pins(SeqLeakPins).Gate = tlOff 'insure all ppmu's are gated off

''''''use the "theexec.DataManager.DecomposePinList" to serialize the pins to be tested sequentially'''''
TheExec.DataManager.DecomposePinList SeqLeakPins, PinArr(), PinCount


''Load & Run Pattern, wait for PAT to finish, set Ports 4-7 to tri-state
  TheHdw.Patterns(PatternFile).Load
  TheHdw.Patterns(PatternFile).Start ""
  While TheHdw.Digital.Patgen.IsRunning = True
  Wend
   TheHdw.Digital.Patgen.Halt

' For loop for Leakage Low (ForceV_IiL)
    For i = 0 To PinCount - 1
    
        With TheHdw.PPMU(PinArr(i))
            TheHdw.Digital.Pins(PinArr(i)).Disconnect 'disconnect the pin to be tested from the PE
            .Connect 'connect the ppmu to the pin to be tested to the dut
            .Gate = tlOn 'gate the ppmu on for the pin to be tested
            .ForceV ForceV_IiL, I_Meas_Range 'force voltage, set measure and range
            TheHdw.Wait waitTime 'pause for the force value to stabilize prior to measurement
            measVal = .Read(tlPPMUReadMeasurements) 'make the measurement
 
 ''''Setup OFFLINE Simulation by stuffing the pinlistdata variable with simulation data'''''''
            If TheExec.TesterMode = testModeOffline Then
                For Each Site In TheExec.Sites
                    measVal.Pins(PinArr(i)).Value(Site) = -0.000001 - (Rnd() / 1100000#)
                Next Site
            End If
    
            ''''test the "measVal" against the limits''''
            TheExec.Flow.TestLimit ResultVal:=measVal, unit:=unitAmp, forceval:=ForceV_IiL, _
                                    forceunit:=unitVolt, ForceResults:=tlForceFlow
            .Gate = tlOff 'gate the ppmu off on the tested pin
            .Disconnect  'disconnect the ppmu from the tested pin
            TheHdw.Digital.Pins(PinArr(i)).Connect 'connect the tested pin back to the PE
        End With
    Next i
    TheHdw.PPMU.Pins(SeqLeakPins).Reset tlResetConnections + tlResetSettings 'reset ppmu connections and settings
    TheHdw.PPMU.Pins(SeqLeakPins).Gate = tlOff


    Exit Function
errHandler:
    If AbortTest Then Exit Function Else Resume Next
End Function

