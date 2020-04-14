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
$startbutton.Location = New-Object System.Drawing.Point(20, 30)
$startbutton.Text =  "Lancer DetectionHSL"
$startbutton.add_click({
    & $PSScriptRoot\hslmanager.ps1 start
}) #On lance le script au click
#On ajoute les différents élémets à la GUI 
#Le texte
$bg.Controls.Add($startbutton)
$bg.Controls.Add($exp)
#
$bg.ShowDialog()    #On show le background
#