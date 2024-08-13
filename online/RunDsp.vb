' This GENERATED file contains the definitions for the VBA DSP Procedures imported from the workbook.
' Do not edit!

Imports Teradyne.Igxl.User.TestCodeSupport.DspHelper

Public Class RunDSP


    Public Shared Sub ProcessADCData(ByRef Data_As_DspWave As Object, ByRef NumBits_As_SiteLong As Object,  _
		ByRef FirstVoltage_As_SiteDouble As Object, ByRef LastVoltage_As_SiteDouble As Object,  _
		ByRef EncodingBinary_As_SiteBoolean As Object, ByRef MinADCVolts_As_SiteDouble As Object,  _
		ByRef MaxADCVolts_As_SiteDouble As Object, ByRef HalfLSBTransition_As_SiteBoolean As Object,  _
		ByRef HistAnalysis_As_SiteBoolean As Object, ByRef EndPointFitFlag_As_SiteBoolean As Object,  _
		ByRef DNLLSBUnit_As_SiteLong As Object, ByRef INLLSBUnit_As_SiteLong As Object,  _
		ByRef TUELSBUnit_As_SiteLong As Object, ByRef OffsetLSBUnit_As_SiteLong As Object,  _
		ByRef DNLCheck_As_SiteBoolean As Object, ByRef INLCheck_As_SiteBoolean As Object,  _
		ByRef TUECheck_As_SiteBoolean As Object, ByRef GainCheck_As_SiteBoolean As Object,  _
		ByRef OffsetCheck_As_SiteBoolean As Object, ByRef LSBsBeyond_As_SiteLong As Object,  _
		ByRef svDNLMax_As_SiteDouble As Object, ByRef svDNLMin_As_SiteDouble As Object,  _
		ByRef svINLMax_As_SiteDouble As Object, ByRef svINLMin_As_SiteDouble As Object,  _
		ByRef svTUEMax_As_SiteDouble As Object, ByRef svTUEMin_As_SiteDouble As Object,  _
		ByRef svGainErr_As_SiteDouble As Object, ByRef svOffsetErr_As_SiteDouble As Object,  _
		ByRef svMissingCodes_As_SiteLong As Object)
        RunDspProcedure("ProcessADCData", New DspByRef(Data_As_DspWave), New DspByRef(NumBits_As_SiteLong), New DspByRef(FirstVoltage_As_SiteDouble),  _
		New DspByRef(LastVoltage_As_SiteDouble), New DspByRef(EncodingBinary_As_SiteBoolean),  _
		New DspByRef(MinADCVolts_As_SiteDouble), New DspByRef(MaxADCVolts_As_SiteDouble),  _
		New DspByRef(HalfLSBTransition_As_SiteBoolean), New DspByRef(HistAnalysis_As_SiteBoolean),  _
		New DspByRef(EndPointFitFlag_As_SiteBoolean), New DspByRef(DNLLSBUnit_As_SiteLong),  _
		New DspByRef(INLLSBUnit_As_SiteLong), New DspByRef(TUELSBUnit_As_SiteLong),  _
		New DspByRef(OffsetLSBUnit_As_SiteLong), New DspByRef(DNLCheck_As_SiteBoolean),  _
		New DspByRef(INLCheck_As_SiteBoolean), New DspByRef(TUECheck_As_SiteBoolean),  _
		New DspByRef(GainCheck_As_SiteBoolean), New DspByRef(OffsetCheck_As_SiteBoolean),  _
		New DspByRef(LSBsBeyond_As_SiteLong), New DspByRef(svDNLMax_As_SiteDouble),  _
		New DspByRef(svDNLMin_As_SiteDouble), New DspByRef(svINLMax_As_SiteDouble),  _
		New DspByRef(svINLMin_As_SiteDouble), New DspByRef(svTUEMax_As_SiteDouble),  _
		New DspByRef(svTUEMin_As_SiteDouble), New DspByRef(svGainErr_As_SiteDouble),  _
		New DspByRef(svOffsetErr_As_SiteDouble), New DspByRef(svMissingCodes_As_SiteLong))
    End Sub

    Public Shared Sub ProcessADCDataAC(ByRef WaveData_As_DspWave As Object, ByRef NumBits_As_SiteLong As Object,  _
		ByRef EncodingBinary_As_SiteBoolean As Object, ByRef SNRCheck_As_SiteBoolean As Object,  _
		ByRef THDCheck_As_SiteBoolean As Object, ByRef SINADCheck_As_SiteBoolean As Object,  _
		ByRef SFDRCheck_As_SiteBoolean As Object, ByRef svSNR_As_SiteDouble As Object,  _
		ByRef svTHD_As_SiteDouble As Object, ByRef svSINAD_As_SiteDouble As Object,  _
		ByRef svSFDR_As_SiteDouble As Object, ByRef svH2_As_SiteDouble As Object, ByRef svH3_As_SiteDouble As Object,  _
		ByRef NumH_As_SiteLong As Object)
        RunDspProcedure("ProcessADCDataAC", New DspByRef(WaveData_As_DspWave), New DspByRef(NumBits_As_SiteLong), New DspByRef(EncodingBinary_As_SiteBoolean),  _
		New DspByRef(SNRCheck_As_SiteBoolean), New DspByRef(THDCheck_As_SiteBoolean),  _
		New DspByRef(SINADCheck_As_SiteBoolean), New DspByRef(SFDRCheck_As_SiteBoolean),  _
		New DspByRef(svSNR_As_SiteDouble), New DspByRef(svTHD_As_SiteDouble), New DspByRef(svSINAD_As_SiteDouble),  _
		New DspByRef(svSFDR_As_SiteDouble), New DspByRef(svH2_As_SiteDouble), New DspByRef(svH3_As_SiteDouble),  _
		New DspByRef(NumH_As_SiteLong))
    End Sub
End Class
