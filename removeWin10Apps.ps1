#   Description:
# This script removes unwanted Apps that come with Windows. If you  do not want
# to remove certain Apps comment out the corresponding lines below.



$apps = @(
    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    # "Microsoft.WindowsStore"
    "Microsoft.XboxApp"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxGameCallableUI"
    "Microsoft.Wallet"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "microsoft.windowscommunicationsapps"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.GetHelp"
    "Microsoft.Windows.Cortana"
    "Microsoft.Windows.HolographicFirstRun"
    "Microsoft.Print3D"
    
    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"

    #Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingTravel"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.WindowsReadingList"

   

   
)

foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

    Get-AppXProvisionedPackage -Online |
        Where-Object DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online
}
