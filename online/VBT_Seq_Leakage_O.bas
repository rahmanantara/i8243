Attribute VB_Name = "VBT_Seq_Leakage"
Option Explicit


Public Function SeqLeakage(SeqLeakPins As PinList, ForceV_IiH As Double, ForceV_IiL As Double, _
                        waitTime As Double, Init_HiPins As PinList, Init_LoPins As PinList, _
                        Optional I_Meas_Range As Double) As Long

Dim site As Variant
Dim PinArr() As String, PinCount As Long, i As Long
Dim measVal As New PinListData

'''''''Connect all signal pins (digital_pins) to the pin electronics and apply levels'''''''''''
thehdw.Digital.ApplyLevelsTiming True, True, False, tlPowered, Init_HiPins.Value, Init_LoPins.Value
thehdw.PPMU.Pins(SeqLeakPins).Gate = tlOff 'insure all ppmu's are gated off

''''''use the "theexec.DataManager.DecomposePinList" to serialize the pins to be tested sequentially'''''
TheExec.DataManager.DecomposePinList SeqLeakPins, PinArr(), PinCount

' For loop for Leakage High (ForceV_IiH)
    For i = 0 To PinCount - 1
    
        With thehdw.PPMU(PinArr(i))
            thehdw.Digital.Pins(PinArr(i)).Disconnect 'disconnect the pin to be tested from the PE
            .Connect 'connect the ppmu to the pin to be tested to the dut
            .Gate = tlOn 'gate the ppmu on for the pin to be tested
            .ForceV ForceV_IiH, I_Meas_Range 'force voltage, set measure and range
            thehdw.Wait waitTime 'pause for the force value to stabilize prior to measurement
             measVal = .Read(tlPPMUReadMeasurements) 'make the measurement
  
  ''''Setup OFFLINE Simulation by stuffing the pinlistdata variable with simulation data'''''''
    If TheExec.TesterMode = testModeOffline Then
        For Each site In TheExec.Sites
            measVal.Pins(PinArr(i)).Value(site) = 0.00000019 + (Rnd() / 25000000#)
        Next site
    End If

    If (TheExec.CurrentJob = "TI245") Then
            ''''test the "measVal" against the limits''''
            TheExec.Flow.TestLimit ResultVal:=measVal, unit:=unitAmp, forceVal:=ForceV_IiH, _
                                    forceunit:=unitVolt, forceresults:=tlForceFlow
    Else
            TheExec.Flow.TestLimit ResultVal:=measVal, unit:=unitAmp, forceVal:=ForceV_IiH, _
                                    forceunit:=unitVolt, forceresults:=tlForceFlow
    End If
            .Gate = tlOff 'gate the ppmu off on the tested pin
            .Disconnect  'disconnect the ppmu from the tested pin
            thehdw.Digital.Pins(PinArr(i)).Connect 'connect the tested pin back to the PE
        End With
    Next i
    
' For loop for Leakage Low (ForceV_IiL)
    For i = 0 To PinCount - 1
    
        With thehdw.PPMU(PinArr(i))
            thehdw.Digital.Pins(PinArr(i)).Disconnect 'disconnect the pin to be tested from the PE
            .Connect 'connect the ppmu to the pin to be tested to the dut
            .Gate = tlOn 'gate the ppmu on for the pin to be tested
            .ForceV ForceV_IiL, I_Meas_Range 'force voltage, set measure and range
            thehdw.Wait waitTime 'pause for the force value to stabilize prior to measurement
            measVal = .Read(tlPPMUReadMeasurements) 'make the measurement
 
 ''''Setup OFFLINE Simulation by stuffing the pinlistdata variable with simulation data'''''''
        If TheExec.TesterMode = testModeOffline Then
            For Each site In TheExec.Sites
                measVal.Pins(PinArr(i)).Value(site) = -0.000014 - (Rnd() / 110000#)
            Next site
        End If
    
       If (TheExec.CurrentJob = "TI245") Then
            ''''test the "measVal" against the limits''''
             TheExec.Flow.TestLimit ResultVal:=measVal, unit:=unitAmp, forceVal:=ForceV_IiL, _
                                    forceunit:=unitVolt, forceresults:=tlForceFlow
        Else
             TheExec.Flow.TestLimit ResultVal:=measVal, unit:=unitAmp, forceVal:=ForceV_IiL, _
                                    forceunit:=unitVolt, forceresults:=tlForceFlow
        End If
            .Gate = tlOff 'gate the ppmu off on the tested pin
            .Disconnect  'disconnect the ppmu from the tested pin
            thehdw.Digital.Pins(PinArr(i)).Connect 'connect the tested pin back to the PE
        End With
    Next i
  thehdw.PPMU.Pins(SeqLeakPins).Reset tlResetConnections + tlResetSettings 'reset ppmu connections and settings
  thehdw.PPMU.Pins(SeqLeakPins).Gate = tlOff
End Function


