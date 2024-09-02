Attribute VB_Name = "VBT_RiseT"
Option Explicit

''''About the code:
''''Purpose: Interpose function to calculate the rise time based on CZ studio measure results.
''''Where to use: Call this function in the "Post Step" IP function of 90% search point.
''''Note: All the CZ setup names,limits and pin names are hardcoded.

Public Function RiseTime_IP_Module(argc As Long, argv() As String) As Long

    On Error GoTo errHandler

'Declaring a user variable as an Rta Data Object
Dim dataobj As New RtaDataObj

Dim SiteNum As Long
Dim StartPnt As Double
Dim EndPnt As Double
Dim Risetime As Double
Dim ResultStr As String
Dim TestNum As Long
Dim TestFlag As Long
Dim ParaFlag As Long
Dim PinName As String
Dim ChanNum As Long
Dim LowLimit As Double
Dim HighLimit As Double
Dim measVal As Double
Dim MeasUnits As Long
Dim ForceVal As Double
Dim ForceUnits As Long

'Setting the object to point to a particular characterization setup
Set dataobj = TheExec.DevChar.ActiveDataObject
Call dataobj.SetPt(0, 0, 0)

LowLimit = 0.000000001 '1ns
HighLimit = 0.0000001  '100ns

TestFlag = logTestFail
ParaFlag = parmLow
MeasUnits = unitTime

With dataobj
    For SiteNum = 0 To .SiteDim
        .site = SiteNum
            
            Call TheExec.Datalog.WriteComment(" ")
            Call TheExec.Datalog.WriteComment("================")
            Call TheExec.Datalog.WriteComment("Site " & CStr(SiteNum))
            Call TheExec.Datalog.WriteComment("================")
            
            If .MeasVals("rise_10pt") Like "*Stuck*" Then
                StartPnt = -0.000003
                Call TheExec.Datalog.WriteComment("The 10% point is " & .MeasVals("rise_10pt"))
            Else
                StartPnt = .MeasVals("rise_10pt")
                Call TheExec.Datalog.WriteComment("The 10% point is " & CStr(StartPnt * 1000000000#) & " nS")
            End If
            If .MeasVals("rise_90pt") Like "*Stuck*" Then
                EndPnt = 0.000003
                Call TheExec.Datalog.WriteComment("The 90% point is " & .MeasVals("rise_90pt"))
            Else
                EndPnt = .MeasVals("rise_90pt")
                Call TheExec.Datalog.WriteComment("The 90% point is " & CStr(EndPnt * 1000000000#) & " nS")
            End If
                        
            'Rise time calculation with measured start and end points
            Risetime = EndPnt - StartPnt
            
            If .MeasVals("rise_10pt") Like "*Stuck*" Or .MeasVals("rise_90pt") Like "*Stuck*" Then
                Call TheExec.Datalog.WriteComment("Unable to determine rise time for site " & CStr(SiteNum))
            Else
                Call TheExec.Datalog.WriteComment("Rise time for site " & CStr(SiteNum) & " = " & CStr(Risetime * 1000000000#) & " nS")
            End If
                        
            'Limit check with the test limts
            measVal = Risetime
            If measVal < LowLimit Then
                TestFlag = logTestFail
                ParaFlag = parmLow
            ElseIf (measVal >= LowLimit And measVal <= HighLimit) Then
                TestFlag = logTestPass
                ParaFlag = parmPass
            Else
                TestFlag = logTestFail
                ParaFlag = parmHigh
            End If
            
            TestNum = TheExec.Sites(SiteNum).TestNumber
            ResultStr = "rise time = " & CStr(Risetime)
            PinName = "A8"
                        
            'Result printout to the datalog
            Call TheExec.Datalog.WriteComment(" ")
            Call TheExec.Datalog.WriteParametricResult(SiteNum, TestNum, TestFlag, _
                ParaFlag, PinName, ChanNum, LowLimit, measVal, HighLimit, MeasUnits, _
                ForceVal, ForceUnits, 0)
        
        Next SiteNum
        
End With

Call TheExec.Datalog.WriteComment(" ")
Call TheExec.Datalog.WriteComment("End rise time interpose function")
Call TheExec.Datalog.WriteComment("================================ ")
Call TheExec.Datalog.WriteComment(" ")
        
Exit Function
errHandler:
    If AbortTest Then Exit Function Else Resume Next
End Function
