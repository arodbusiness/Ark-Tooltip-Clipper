#Include Gdip_All.ahk
#SingleInstance Force
If !pToken := Gdip_Startup(){
	MsgBox, No Gdiplus 
	ExitApp
}
Dir := A_ScriptDir . "\Captures" 
if (!FileExist(Dir))
	FileCreateDir, %Dir%


Columns := 6
Rows := 7
TooltipW := 710


TooltipH := 300  		;;;;;;;;;;;;;;;;;;;;;;;;;;;Guns/Tek
;;;TooltipH := 225 	;;;;;;;;;;;;;;;;;;;;;;;;;;;Saddles



Width := TooltipW*Columns
Height := TooltipH*Rows


Right::
	TooltipH := 300
	Tooltip, Capture Height is now %TooltipH%
	Sleep, 500
	Tooltip
return

Left::
	TooltipH := 225
	Tooltip, Capture Height is now %TooltipH%
	Sleep, 500
	Tooltip
return


F8::
	FilePath := Dir "\" A_Now ".jpg"
	pBitmap := Gdip_CreateBitmap(TooltipW, TooltipH)
	G := Gdip_GraphicsFromImage(pBitmap)

	Gdip_SetSmoothingMode(G, 2)
	Gdip_SetInterpolationMode(G, 7)
	
	MouseGetPos , MouseX, MouseY
	
	ScreenArg := MouseX-TooltipW-TooltipW*0.075 "|" MouseY-TooltipH+TooltipH*0.1 "|" TooltipW+20 "|" TooltipH+20
	
	CapturedBitmap := Gdip_BitmapFromScreen(ScreenArg)
	Gdip_SaveBitmapToFile(CapturedBitmap, Filepath)
	Gdip_DeleteGraphics(G)
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(CapturedBitmap)
	SoundBeep
return


F9::
	SoundBeep
	FilePath := Dir "\" A_Now ".jpg"
	pBitmap := Gdip_CreateBitmap(Width, Height)
	G := Gdip_GraphicsFromImage(pBitmap)

	Gdip_SetSmoothingMode(G, 2)
	Gdip_SetInterpolationMode(G, 7)
	
	
	
	Loop % Rows {
		BitmapY := TooltipH*(A_Index-1)
		CurrentY := (0.30+0.0862*(A_Index-1))*A_ScreenHeight
		Loop % Columns {
			BitmapX := TooltipW*(A_Index-1)
			CurrentX := (0.651+0.0485*(A_Index-1))*A_ScreenWidth
			
			MouseMove,%CurrentX%, %CurrentY%
			
			Sleep 100
			
			ScreenArg := CurrentX-TooltipW-10 "|" CurrentY-TooltipH-5 "|" TooltipW "|" TooltipH
			CapturedBitmap := Gdip_BitmapFromScreen(ScreenArg)
			Gdip_DrawImage(G, CapturedBitmap, BitmapX, BitmapY, TooltipW, TooltipH)
			;;Tooltip, %BitmapX%`n%BitmapY%
			
		}
	}
	
	Gdip_SaveBitmapToFile(pBitmap, Filepath)
	Gdip_DeleteGraphics(G)
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(CapturedBitmap)

	SoundBeep
	SoundBeep
return