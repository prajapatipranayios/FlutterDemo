import 'package:flutter_demo_1/app/core/helper/app_strings.dart';
import 'package:get/get.dart';

class InitialController extends GetxController {
  var arrTabbarTop = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
  ];

  var arrTabbarBottom = ['Home', 'Scheduled', 'Chat', 'Notification', 'More'];

  var arrGames = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
    AppString.valorantName,
  ];

  var arrTournaments = [
    AppString.ssbuName,
    AppString.nasb2Name,
    AppString.ssbmName,
    AppString.tekkenName,
    AppString.vf5Name,
    AppString.valorantName,
  ];

  var arrTeams = ['Team A', 'Team B', 'Team C', 'Team D'];

  var arrSSBUInfo = [
    [
      "The Tussly Arena will guide you through your match with the following integrated steps and features:",
      "\u{2022} Lobby\n\u{2022} BattleArena ID Exchange\n\u{2022} Character Selection\n\u{2022} Rock Paper Scissors\n\u{2022} Stage Pick/Ban\n\u{2022} Score Reporting\n\u{2022} Dispute System\n\u{2022} Chat",
      "The Arena is fully customized by the Organizer. All their rules are built into the Arena to remove any confusion of what to do. Follow the Arena prompts and you will always be within the Organizer’s rulesets.",
    ],
    [
      "The Arena will open 30 minutes before your scheduled match time. Once it is open, you will be able to  enter the match lobby.\n\nWhen both teams are in the lobby, your “Proceed” button will be enabled. Once both teams have tapped “Proceed”, you will advance to the BattleArena ID Exchange or the Blind Character Selection (depending on the Organizer’s customizations).",
    ],
    [
      "Organizers can elect to enable the BattleArena ID Exchange in the Arena. This is used for online tournaments and is usually not enabled for LAN tournaments.\n\nIf not enabled, the two players will go straight from the Arena lobby to the Blind Character Selection process.\n\nIf enabled, the host player (usually determined randomly) is responsible for setting up a BattleArena in the game and sending the BattleArena ID to their opponent.",
      "The opponent will receive the BattleArena ID and once both teams confirm that they are in the BattleArena, they will move forward to the Blind Character Selection process for the first game of the match.",
    ],
    [
      "The 1st game in a set is a blind character selection. Both teams will select a character within a time limit designated by the organizer. You will not know who your opponent selected until both selections have been officially submitted.",
      "For the 2nd game onwards. Organizers have several options to customize the Character Selection Process.\n\nThe most used option for SSBU is that the winning player from the previous game selects a character first. The losing player sees who the winning player selected prior to making their own selection.\n\nIn a less used option, the winning player must keep the same Character, but the losing player can change.\n\nFollowing the prompts will always keep you within the designated rules selected by the Organizer.",
      "The character selections have a time limit set by the organizer. If the timer runs out before you select a character, a random character will be automatically selected unless you set a Default Character. You can set a Default Character before your match starts or in between rounds.",
      "The Organizer may have banned certain characters from being used. These will not be available in Character Selection. Any bans are viewable in the League Information section of the app.",
    ],
    [
      "Rock Paper Scissors is used to determine who acts first in the Stage Pick/Ban process of the 1st round. The winner of Rock Paper Scissors decides who bans the first stage.",
    ],
    [
      "Your organizer customized their stage pick/ban. This includes the available starter stages, counter pick stages, number of bans, total stages banned each turn and DSR rules. Every step of this customized process is built into the Arena so that you are prompted when it is your turn to ban or pick.\n\nIn the 1st round, you will pick/ban only from the starter stages. From the 2nd round onwards, you can select from both the starter stages and the counter pick stages.\n\nStages banned by your opponent will have an indicator. You will be informed of the picked stage before the round starts.",
      "Each stage pick and ban has a time limit set by the organizer. If the timer runs out before you select a stage, a random stage(s) will be automatically selected unless you Rank Your Stages. You can rank your stage before your match starts or in between rounds.\n\nIn the ban process, if you do not select a stage before the timer runs out, your lowest ranked stage will be automatically banned.\n\nIn the pick process, if you do not select a stage before the timer runs out, your highest ranked stage will be automatically picked.\n\nIf you do not rank your stages and the timer runs out, a random stage will be banned or picked for you.",
    ],
    [
      "At the end of each round, the score must be reported by tapping the “Report Round Score” button.",
      "You report the score by entering the stocks remaining for each team in the Report Score pop up.",
      "Once either team submits a score, the opposing team will receive a pop up to confirm the reported score. If a reported score is not confirmed by the opposing team in 1 minute, it will be considered confirmed.",
    ],
    [
      "You can dispute a reported score in the score confirmation pop up.",
      "The dispute system gives you 3 options:\n\n1. Dispute with Photo Evidence\n\nYou will first report your score and then the camera will open in the Tussly Arena for you to take a photo of the scoreboard in the game. Your score and photo will be automatically submitted to the Admin and your opponent.\n\n2. Dispute with Score Only\n\nYou input and submit the score you are claiming which will be automatically submitted to the Admin and your opponent.\n\n3. Abandon Dispute\n\nYou can also choose to abandon the dispute and confirm the score your opponent originally reported.",
    ],
    [
      "At any time while in the Arena you can chat with your opponent. A red notification will appear if you have a message from your opponent or the admin.",
    ],
  ];

  var arrImgSSBUInfo = [
    [""],
    ["Sample Image 1 - Lobby"],
    [
      "Sample Image 2 - Enter BattleArena ID",
      "Sample Image 3 - Receive BattleArena ID",
    ],
    [
      "Sample Image 4 - Character Blind Pick",
      "Sample Image 5 - Character Non Blind Pick",
      "Sample Image 6 - Default Character",
      "",
    ],
    ["Sample Image 8 - Rock Paper Scissors"],
    ["Sample Image 7 - Stage Pick.Ban", "Sample Image 9 - Rank Stages"],
    [
      "Sample Image 10 - Report Score Button",
      "Sample Image 11 - Report Score",
      "Sample Image 12 - Confirm Score",
    ],
    [
      "Image - Dispute - Photo - How it works - Step 1-1",
      "Sample Image 14 - Dispute Options",
    ],
    ["Sample Image 15 - Chat"],
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
