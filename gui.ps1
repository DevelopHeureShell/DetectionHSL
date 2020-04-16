Add-type -assembly System.windows.forms
Add-type -assembly System.drawing #On importe les assemblys pour la GUI 
#
$bg = New-object System.windows.forms.form #On crée le background 
#On set les propriétés du BackGround
$bg.AutoSize = $true #L'autosize
$bg.Width = 500 #La largeur
$bg.Height = 600 #La longeur
$bg.StartPosition = "Centerscreen" #La position de démarrage de la fênetre
$bg.Text = "Detection HSL GUI" #Le titre de la fenêtre
#C'est tout pour le BackGround, il est temps de passer au Texte 
$exp = New-Object System.Windows.Forms.Label #On crée le Label (texte)
$exp.AutoSize = $true #On le met en autosize
$exp.Text = "Bienvenue sur DetectionHSL, ce script a pour but de recuperer des informations sur votre ordinateur."
$exp.Location = New-Object System.Drawing.Point(0, 10)
#On crée le startButton
$startbutton = New-Object System.windows.forms.button 
$startbutton.AutoSize  = $true 
$startbutton.Size = New-Object System.Drawing.Size(10, 20)
$startbutton.Location = New-Object System.Drawing.Point(0, 30)
$startbutton.Text =  "Lancer DetectionHSL"
$startbutton.add_click({
    & $PSScriptRoot\hslmanager.ps1 start
}) #On lance le script au click
#On crée le Update Label
$updatelabel = New-object System.Windows.forms.label
$updatelabel.AutoSize = $true
$updatelabel.Location = New-Object System.Drawing.Point(0, 60)
$updatelabel.Text = "Mettre a jour DetectionHSL"
#Le bouton de mise à jour
$updatebutton = New-Object System.Windows.Forms.Button 
$updatebutton.Text = "Maj"
$updatebutton.Size = New-object System.Drawing.Size(5, 20)
$updatebutton.Location = New-object System.Drawing.Point(0, 90)
$updatebutton.AutoSize = $true 
$updatebutton.Add_click({
    & $PSScriptRoot\hslmanager.ps1 update
})
#On ajoute les différents élémets à la GUI 
#Le texte
$bg.Controls.Add($startbutton)
$bg.Controls.Add($exp)
$bg.Controls.add($updatelabel)
$bg.Controls.add($updatebutton)
#
$bg.ShowDialog()    #On show le background
#