## Written and developed by Ben Falzon 2022
## Story planned using https://www.inklewriter.com/
## Based on DragonSlayer by slashadminsource
## https://github.com/slashadminsource/DragonSlayer

# Used so then random numbers are regenerated each time the script is ran
Do {

# Game Variables
$pc = $null
$global:playerDragonTip = $false
$global:runGame         = $true


# Characters Array
# Template:
# Name, Gender Race Class, Weapon, Attack
$characters = @(
    ("Clarissa Stormborn", "Female Human Mage", "Staff of Reckoning", "spin the staff around while chanting some weird incantation, a bolt of lightning  strikes out, hitting the dragon between the eyes,"),
    ("Lukas Stillkind", "Male Elven Archer", "Bow of the Just", "pull two arrows from your quill, letting loose, the arrows fly through the air and   impale the dragon in each of it's eyes,"),
    ("Zelga", "Female Kobold Paladin", "Volcanic Claymore", "run at the imposing beast, it spits a fireball at you and you dodge it. Jumping    over it and into the air, you come down and impale your claymore through it's skull,"),
    ("Urzog Gutwrencher", "Male Orc Barbarian", "Skull Splitters Axe", "when the dragon is moving towards the detachment you rush it, a massive          swing of your axe severs it's head,")
)

# Clear Console
clear-host

#############
#           #
# Functions #
#           #
#############

# Random number for all content except character based things
# Increase / decrease depeninding on what is in CSV files
function random_Number {
 Get-Random -Minimum 0 -Maximum 19
}

# Random number for random character
# Increase / decrease depeninding on how many characters are in the array $characters
function random_char {
 Get-Random -Minimum 0 -Maximum 3
}

# Sleep between text / scenes
function set_sleep {
 Start-Sleep 2
}

# Setup Display function
function setup_display()
{
    $phost   = get-host
    $pwindow = $phost.ui.rawui
    $newsize = $pwindow.windowsize
    $newsize.height = 55
    $newsize.width  = 120
    $pwindow.windowsize = $newsize
}

#Title Screen
function title_screen ()
{
    clear-host

    Write-Host "########################################################################################################################" -ForegroundColor Red
    Write-Host `n
    Write-Host "                 ________            ____                              _          _   __          __        " -ForegroundColor Red
    Write-Host "                /_  __/ /_  ___     / __ \_________ _____ _____  ____ ( )_____   / | / /__  _____/ /_       " -ForegroundColor Red
    Write-Host "                 / / / __ \/ _ \   / / / / ___/ __ '/ __ '/ __ \/ __ \|// ___/  /  |/ / _ \/ ___/ __/       " -ForegroundColor Red
    Write-Host "                / / / / / /  __/  / /_/ / /  / /_/ / /_/ / /_/ / / / / (__  )  / /|  /  __(__  ) /_         " -ForegroundColor Red
    Write-Host "               /_/ /_/ /_/\___/  /_____/_/   \__,_/\__, /\____/_/ /_/ /____/  /_/ |_/\___/____/\__/         " -ForegroundColor Red
    Write-Host "                                                  /____/                                                    " -ForegroundColor Red
    Write-Host `n
    Write-Host "   ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~  ~   " -ForegroundColor green
    Write-Host `n
    Write-host "                                       ______________                    " -ForegroundColor Green
    Write-host "                                 ,===:'.,            `-._                " -ForegroundColor Green
    Write-host "                                      `:.`---.__         `-._            " -ForegroundColor Green
    Write-host "                                        `:.     `--.         `.          " -ForegroundColor Green
    Write-host "                                          \.        `.         `.        " -ForegroundColor Green
    Write-host "                                  (,,(,    \.         `.   ____,-`.,     " -ForegroundColor Green
    Write-host "                               (,'     `/   \.   ,--.___`.'              " -ForegroundColor Green
    Write-host "                           ,  ,'  ,--.  `,   \.;'         `              " -ForegroundColor Green
    Write-host "                            `{D, {    \  :    \;                         " -ForegroundColor Green
    Write-host "                              V,,'    /  /    //                         " -ForegroundColor Green
    Write-host "                              j;;    /  ,' ,-//.    ,---.      ,         " -ForegroundColor Green
    Write-host "                              \;'   /  ,' /  _  \  /  _  \   ,'/         " -ForegroundColor Green
    Write-host "                                    \   `'  / \  `'  / \  `.' /          " -ForegroundColor Green
    Write-host "                                     `.___,'   `.__,'   `.__,'           " -ForegroundColor Green
    Write-Host `n
    Write-host "                                                                                     A role playing game by Ben Falzon" -ForegroundColor Magenta
    Write-host "                                                                                              written in PowerShell >_" -ForegroundColor Magenta
    Write-Host `n
    Write-Host "########################################################################################################################" -ForegroundColor Red
    Write-host `n
    
    $title_screen_menu = read-host -Prompt "  P to play or Q to quit"

    if($title_screen_menu -eq "P"){
        write-host("  Let's begin!") -ForegroundColor Yellow 
        set_sleep
        character_selection
     } elseif($title_screen_menu -eq "Q"){
        write-host("  Farewell for now!") -ForegroundColor Yellow
        
     } else {
        write-host("  Please choose P or Q.")
        set_sleep
        title_screen
     }
}


# Character Selection
function character_selection()
{
    #Clear Console
    clear-host

    Write-Host "########################################################################################################################" -ForegroundColor Red
    Write-Host "#                                                                                                                      #" -ForegroundColor Red
    Write-Host "#                                                                                                                      #" -ForegroundColor Red
    Write-Host "#                                         The Dragon's Nest by Ben Falzon                                              #" -ForegroundColor Red
    Write-Host "#                                                                                                                      #" -ForegroundColor Red
    Write-Host "#                                    Based on Dragon Slayer 1.0 by Ian Waters                                          #" -ForegroundColor Red
    Write-Host "#                                        www.slashadmin.co.uk \ Life In IT                                             #" -ForegroundColor Red
    Write-Host "#                                                                                                                      #" -ForegroundColor Red
    Write-Host "#                                                                                                                      #" -ForegroundColor Red
    Write-Host "########################################################################################################################" -ForegroundColor Red
    Write-Host `n
    Write-Host "                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                         " -ForegroundColor Green
    Write-Host `n
    Write-Host "                                                 ~~ Character Selection ~~                                              " -ForegroundColor Green
    Write-Host `n
    
    foreach ($char in $characters) {
        $i++
        write-host "                                          $($i). $($char[0]) - $($char[1])" -ForegroundColor Green
    }

    Write-Host `n
    Write-Host "                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                         " -ForegroundColor Green
    Write-Host `n

    $userResponse = Read-Host -Prompt "  Choose your character (1 - 4 or enter for random)"

    Switch ($userResponse) 
    { 
            1 {$pc = 0}
            2 {$pc = 1} 
            3 {$pc = 2} 
            4 {$pc = 3} 
            default {$pc = $ranChar}
    }

    Write-Host "  You selected $($characters[$($pc)][0]), let's begin!"  -ForegroundColor Yellow

    set_sleep
    $i = 0
    kings_request
}

# Kings Request
function kings_request()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  You arrive at a village called $($townName1) in $($countryName1), as you make your way to the town square, "
    Write-Host "  a message boy approaches and informs you that you have been summoned by the honorable King Grigor Fota!"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n   
    write-host "  1. Accept and go see the king." -ForegroundColor Yellow
    write-host "  2. Decline and do your own thing." -ForegroundColor Yellow
    Write-Host `n
    $kings_request_menu = read-host -Prompt "  Please choose an option (1 or 2)"

    if($kings_request_menu -eq 1){
        write-host("  You accept and go see the king!") -ForegroundColor Yellow
        set_sleep
        Accept_Kings_Request
     } elseif($kings_request_menu -eq 2){
        write-host("  You slap the message boy, telling him to stay out of your way!") -ForegroundColor Yellow
        set_sleep
        decline_kings_request
     } else {
        write-host("  Please choose 1 or 2.") -ForegroundColor Red
        set_sleep
        kings_request
     }
}

# Decline Kings Request
function decline_kings_request()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  The boy runs away screaming and crying, you panic but it is too late, in the distance you see a knight galloping      "
    Write-Host "  towards you on a horse."
    Write-Host `n
    Write-Host "  As he approaches the horse comes a halt, the knight dismounts, 'How dare you disrespect King Grigor Fota in such      "
    Write-Host "  a manor!' Yelled the heavily armored knight."
    Write-Host `n
    Write-Host "  He rushes you, drawing his great sword! Swinging left and right you dodge the first two attacks but you're too slow"
    Write-Host "  for the third. A thrust forward the knight managed to stab you through the heart. You fall to the ground,"
    Write-Host "  bleeding out, everything turns black..."
    Write-Host `n
    Write-Host "  Game over!" -ForegroundColor Red
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
 
}

# Accept kings request
function accept_kings_request()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  'Welcome lonely traveler, and what is your name?' asks the king."
    Write-Host `n
    Write-Host "  You reply 'I am $($characters[$($pc)][0]), the $($characters[$($pc)][1]) from $($playerTownName), surely you have heard of me?!'" -ForegroundColor Cyan
    Write-Host `n
    Write-Host "  'That I have, $($characters[$($pc)][0]) of $($playerTownName) for I am King Grigor Fota, and my knowledge is vast!'"
    Write-Host "  bragged the king."
    Write-Host `n
    Write-Host "  'However I have asked you upon here as I am in dire need of a hero.' Explains the king."
    Write-Host `n
    Write-Host "  'My wife the Lady Amalia has fallen ill, and the only cure is the yolk of a dragon's egg. Will you head north to"
    Write-Host "  $($townName2) situated near the $($locationType1) of $($countryName2)? It is there that the great dragon has built it's nest.'"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    write-host "  1. Accept the mission." -ForegroundColor Yellow
    write-host "  2. Decline the mission." -ForegroundColor Yellow
    Write-Host `n
    $accept_king_menu = read-host -Prompt "  Please choose an option (1 or 2)"

    if($accept_king_menu -eq 1){
        write-host("  You accept the mission to save Lady Amalia.") -ForegroundColor Yellow
        set_sleep
        accept_mission
     } elseif($accept_king_menu -eq 2){
        write-host("  You delcine the mission to save Lady Amalia.") -ForegroundColor Yellow
        set_sleep
        decline_mission
     } else {
        write-host("  Please choose 1 or 2.") -ForegroundColor Red
        set_sleep
        accept_kings_request
     }
}

# Decline mission
function decline_mission()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  Guards rush the room and take you captive. They lock you up in the dungeons and leave you there to rot."
    Write-Host `n
    Write-Host "  Game over!" -ForegroundColor Red
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
  
}

# Accept mission
function accept_mission()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  The king thanks you $($characters[$($pc)][0]) for accepting his call to help and hands you a $($characters[$($pc)][2])"
    Write-Host "  to aid you on your journey."
    Write-Host `n
    Write-Host "  You load up a horse and ride heading north towards $($townName2)."
    Write-Host `n
    Write-Host "  After two day's ride you arrive at $($townName3), a small village on the outskirts of the $($townName2)."
    Write-Host `n
    Write-Host "  You choose $($townName3) to make your stand due to its remote location and an army detachment camping nearby."
    Write-Host `n
    Write-Host "  On your arrival do you?"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n   
    write-host "  1. Talk to the commander in charge of the local detachment." -ForegroundColor Yellow
    write-host "  2. Talk to the elder of the village." -ForegroundColor Yellow
    write-host "  3. Learn about the commander." -ForegroundColor Yellow
    write-host "  4. Learn about the village elder." -ForegroundColor Yellow
    Write-Host `n
    $accept_mission_menu = read-host -Prompt "  Please choose an option (1 - 4)"

    if($accept_mission_menu -eq 1){
        write-host("  You decide to talk to the commander first.") -ForegroundColor Yellow
        set_sleep
        commander_first
     } elseif($accept_mission_menu -eq 2){
        write-host("  You decide to talk to the villagers first.") -ForegroundColor Yellow
        set_sleep
        villagers_first
     } elseif($accept_mission_menu -eq 3){
        write-host("  You want to know more about $($npc1_1).") -ForegroundColor Yellow
        set_sleep
        npc1_about
    } elseif($accept_mission_menu -eq 4){
        write-host("  You want to know more about $($npc2_1).") -ForegroundColor Yellow
        set_sleep
        npc2_about
     } else {
        write-host("  Please choose 1 - 4.") -ForegroundColor Red
        set_sleep
        accept_mission
     }
}

# npc1 about
function npc1_about()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  Name:        $($npc1_1)"
    Write-Host "  Age:         $($npc1_2)"
    Write-Host "  Gender:      $($npc1_3)"
    Write-Host "  Race:        $($npc1_4)"
    Write-Host "  Occupation:  Commander of the $($townName2) army"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n

    Pause
    accept_mission   
}

# npc2 about
function npc2_about()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  Name:        $($npc2_1)"
    Write-Host "  Age:         $($npc2_2)"
    Write-Host "  Gender:      $($npc2_3)"
    Write-Host "  Race:        $($npc2_4)"
    Write-Host "  Occupation:  $($npc2_5)"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n

    Pause
    accept_mission   
}

# Commander First
function commander_first()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  You speak to $($npc1_1) who is commanding the local detachment of soldiers. $($npc1_1) is making their"
    Write-Host "  way north to rejoin the rest of the troops but is willing to assist in finding the dragon and suggests waiting until"
    Write-Host "  she returns and slay her in combat."
    Write-Host `n
    Write-Host "  You setup camp with the detachment and prepare the weapons."
    Write-Host `n
    Write-Host "  During the night the dragon attacks the camp and villagers. Everyone runs for their lives but you are engulfed in"
    Write-Host "  flames and don't make it out alive!"
    Write-Host `n
    Write-Host "  You have failed to protect the villagers and save the Lady Amalia."
    Write-Host `n
    Write-Host "  Game over!" -ForegroundColor Red
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
   
}

# Villagers first
function villagers_first()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  You speak to $($npc2_1) an elder of the village who explains that the dragon has been seen resting in a cave"
    Write-Host "  nearby after nightfall. $($npc2_1) suggests speaking to the local detachment and launching a surprise attack"
    Write-Host "  after dark with their help."
    Write-Host `n
    Write-Host "  What do you want to do now?"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n   
    write-host "  1. Speak to the detachments commander." -ForegroundColor Yellow
    write-host "  2. Ask $($npc2_1) to take you to the cave after dark." -ForegroundColor Yellow
    Write-Host `n
    $villagers_first_menu = read-host -Prompt "  Please choose an option (1 or 2)"

    if($villagers_first_menu -eq 1){
        write-host("  You go talk to the commander after speaking with $($npc2_1).") -ForegroundColor Yellow
        set_sleep
        commander_second_part1
     } elseif($villagers_first_menu -eq 2){
        write-host("  You ask $($npc2_1) to take you to the cave.") -ForegroundColor Yellow
        set_sleep
        cave_first
     } else {
        write-host("  Please choose 1 or 2.") -ForegroundColor Red
        set_sleep
        villagers_first
     }
}

# Cave first
function cave_first()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  After dark, $($npc2_1) takes you to the cave and leaves you to investigate. You get close to the cave but can't"
    Write-Host "  see any sign of the dragon so you move closer still. Suddenly you hear a noise from behind! you turn quickly"
    Write-Host "  and are engulfed by flames!"
    Write-Host `n
    Write-Host "  The dragon has struck you down with her fire breath and you are turned to a pile of ashes."
    Write-Host `n
    Write-Host "  Game over!" -ForegroundColor Red
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
  
}

# Commander second part 1
function commander_second_part1()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  You speak to $($npc1_1) who is commanding the local detachment of soldiers. $($npc1_1) is making"
    Write-Host "  their way north to rejoin the rest of the troops but is willing to assist in finding the dragon's nest."
    Write-Host `n
    Write-Host "  You tell $($npc1_1) that the local villagers know where the dragon may be resting at night, together you"
    Write-Host "  formulate a plan of attack."
    Write-Host `n
    Write-Host "  You ready your weapons and with the villagers help you formulate a plan."
    Write-Host `n
    Write-Host "  The plan is to setup a large chain mail net over the cave entrance. When the dragon enters the cave to rest you"
    Write-Host "  will drop the net to block her escape. The troops will then fire their bows into the cave and slay the dragon!"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n

    pause
    commander_second_part2
}

# Commander second part 2
function commander_second_part2()
{
    #Clear Console
    clear-host

    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n
    Write-Host "  During the night the dragon enters the cave and the trap is sprung. Huge arrows are fired into the cave and fire"
    Write-Host "  billowed out from it's entrance, the chain mail melts and the dragon makes it's way to the entrance."
    Write-Host `n
    Write-Host "  You ready your $($characters[$($pc)][2]) and $($characters[$($pc)][3]) the dragon falls to a heap."
    Write-Host `n
    Write-Host "  You enter the cave and recover an egg for King Grigor."
    Write-Host `n
    Write-Host "  Congratulations!" -ForegroundColor Magenta
    Write-Host `n
    Write-Host "  You have defeated the dragon and saved the Lady Amalia."
    Write-Host "  You are indeed a cunning and mighty warrior!"
    Write-Host `n
    Write-Host "  The end!"
    Write-Host `n
    Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor Green
    Write-Host `n

}


########################
#                      #
# Ben Falzon Variables #
#                      #
########################

# Import all csv files from \source_files
$npc  = Import-Csv -Path $PSScriptRoot\source_files\npc.csv
$towns  = Import-Csv -Path $PSScriptRoot\source_files\towns.csv
$locations  = Import-Csv -Path $PSScriptRoot\source_files\locations.csv
$countries  = Import-Csv -Path $PSScriptRoot\source_files\countries.csv

# Random numbers so the story is different each time
$num1 = random_Number
$num2 = random_Number
$num3 = random_Number
$num4 = random_Number
$ranChar = random_char

# Story content
# Towns
$townName1 = $towns.town[$num1]             # Town where the story begins
$townName2 = $towns.town[$num2]             # Town where the dragon is
$townName3 = $towns.town[$num3]             # Small village near town 2
$playerTownName = $towns.town[$num4]        # Town where the player is from
# Countries
$countryName1 = $countries.country[$num1]   # Country where the story begins
$countryName2 = $countries.country[$num2]   # Country where the dragon is
# Locations
$locationType1 = $locations.location[$num1] # The location where the dragon is
# NPCs
$npc1_1 = $npc.name[$num1]                    # Commander of the local detatchment\
$npc1_2 = $npc.age[$num1]
$npc1_3 = $npc.gender[$num1]
$npc1_4 = $npc.race[$num1]
$npc2_1 = $npc.name[$num2]                    # Elder of the small village
$npc2_2 = $npc.age[$num2]
$npc2_3 = $npc.gender[$num2]
$npc2_4 = $npc.race[$num2]
$npc2_5 = $npc.occupation[$num2]


##################
#                #
#    Run Game    #
#                #
##################

setup_display

title_screen



Do{
   $again = Read-host "  Thankyou for playing my game, do you want to play again? (Y or N)"
   If(($again -eq "Y") -or ($again -eq "N")){
      $go = $true
   }
   Else{
      write-host `n
      write-host "  Invalid input. Please try again"  -ForegroundColor Red
      write-host `n
   }
   }Until($go)
   
   }
   Until($again -eq "N")

   write-host `n
   write-host("  Farewell for now!") -ForegroundColor Yellow