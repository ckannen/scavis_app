import 'package:scavis/survey/components/questionnaire/types/questionnaire-answer.dart';
import 'package:scavis/survey/components/questionnaire/types/questionnaire-question.dart';
import 'package:scavis/survey/components/questionnaire/template/questionnaire-template.dart';

class Sozio2Questionnaire extends QuestionnaireTemplate {
  @override
  String id = "18_CB_SOZIO_amEnde";

  @override
  String introduction = "Abschließend benötigen wir noch ein paar Angaben zu Ihrer wohnlichen und beruflichen Situation.";

  @override
  List<QuestionnaireQuestion> questions = [
    QuestionnaireQuestion(questionId: "soz_4", text: "Welchen höchsten allgemeinbildenden Schulabschluss haben Sie?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Schule beendet ohne Abschluss", value: 1),
      AnswerOption(label: "Volks-/Hauptschulabschluss", value: 2),
      AnswerOption(label: "Mittlere Reife, Realschulabschluss (Fachschulreife)", value: 3),
      AnswerOption(label: "Polytechnische Oberschule (POS) mit Abschluss 8. Klasse", value: 4),
      AnswerOption(label: "Polytechnische Oberschule (POS) mit Abschluss 10. Klasse", value: 5),
      AnswerOption(label: "Fachhochschulreife (Abschluss einer Fachoberschule etc.)", value: 6),
      AnswerOption(label: "Abitur (Hochschulreife) oder erweiterte Oberschule (EOS) mit Abschluss 12. Klasse oder Berufsausbildung mit Abitur", value: 7),
      AnswerOption(label: "Einen anderen Schulabschluss", value: 8),
    ]),

    // Logik: wenn "einen anderen Schulabschluss", dann soz_4_text, sonst weiter mit soz_5
    QuestionnaireQuestion(questionId: "soz_4_text", text: "Welcher „andere Abschluss“?", type: AnswerFieldType.TEXT, options: {"keyboard": "text", "validation": "text"}),
    QuestionnaireQuestion(questionId: "soz_5", text: "Welchen höchsten beruflichen Ausbildungsabschluss haben Sie?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Abschluss einer beruflich-betrieblichen Berufsausbildung (Lehre)", value: 1),
      AnswerOption(label: "Abschluss einer beruflich-schulischen Ausbildung (Berufsfach- oder Handelsschule)", value: 2),
      AnswerOption(label: "Abschluss an einer Fachschule, Meister- oder Technikerschule, Berufs- oder Fachakademie", value: 3),
      AnswerOption(label: "Fachhochschulabschluss", value: 4),
      AnswerOption(label: "Hochschulabschluss", value: 5),
      AnswerOption(label: "Einen anderen Abschluss", value: 6),
      AnswerOption(label: "Keinen Ausbildungsabschluss", value: 7),
      AnswerOption(label: "Ich bin Schüler*in / noch in der Ausbildung / noch im Studium", value: 8),
    ]),
    // Logik: Wenn "Einen anderen Abschluss", dann "soz_5_text", sonst weiter mit soz_6
    QuestionnaireQuestion(questionId: "soz_5_text", text: "Welcher „andere Ausbildungsabschluss“?", type: AnswerFieldType.TEXT, options: {"keyboard": "text", "validation": "text"}),
    QuestionnaireQuestion(questionId: "soz_6", text: "Sind Sie zurzeit erwerbstätig?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Vollzeit erwerbstätig mit einer wöchentlichen Arbeitszeit von 35 Stunden und mehr", value: 1),
      AnswerOption(label: "Teilzeit erwerbstätig mit einer wöchentlichen Arbeitszeit von 15 bis 34 Stunden ", value: 2),
      AnswerOption(label: "Teilzeit / stundenweise erwerbstätig mit einer wöchentlichen Arbeitszeit unter 15 Stunden ", value: 3),
      AnswerOption(label: "Nicht erwerbstätig ", value: 4),
      AnswerOption(label: "In Kurzarbeit", value: 5),
    ]),
    // Logik: Wenn "Teilzeit- / stundenweise erwerbstätig mit einer wöchentlichen Arbeitszeit unter 15 Stunden" ODER "Nicht erwerbstätig", dann "soz_6_1". Sonst weiter mit "soz_7"
    QuestionnaireQuestion(questionId: "soz_6_1", text: "Wenn Sie weniger als 15 Stunden oder nicht erwerbstätig sind, sind Sie dann:", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "In Ausbildung / Studium / Umschulung", value: 1),
      AnswerOption(label: "Arbeitslos seit weniger als 6 Monaten", value: 2),
      AnswerOption(label: "Arbeitslos seit mehr als 6 Monaten, aber weniger als 2 Jahre", value: 3),
      AnswerOption(label: "Arbeitslos seit mehr als 2 Jahren", value: 4),
      AnswerOption(label: "Hausfrau/ Hausmann", value: 5),
      AnswerOption(label: "Wehrdienstleistende*r / freiwilliges soziales Jahr", value: 6),
      AnswerOption(label: "In Mutterschutz / Erziehungsurlaub", value: 7),
      AnswerOption(label: "In Vorruhestand / Rente / Pension", value: 8),
      AnswerOption(label: "Sonstiges", value: 9),
    ]),
    // Logik:
    //  - Wenn "in Ausbildung / Studium / Umschulung", dann "soz_6_1_1"
    //  - Wenn "Sonstiges" dann "soz_6_1_text"
    //  - Else soz_7
    QuestionnaireQuestion(questionId: "soz_6_1_1", text: "In welchem Bereich machen Sie eine Ausbildung?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Handel (Einzel- und Großhandel)", value: 1),
      AnswerOption(label: "Tourismus und Gastgewerbe", value: 2),
      AnswerOption(label: "Technische Berufe (Metall, Kunststoff, Chemie, Elektronik)", value: 3),
      AnswerOption(label: "Informatik und Medien", value: 4),
      AnswerOption(label: "Lebensmittelbranche", value: 5),
      AnswerOption(label: "Baugewerbe und Bergbau", value: 6),
      AnswerOption(label: "Handwerklicher Bereich", value: 7),
      AnswerOption(label: "Büro, Verwaltung, Organisation", value: 8),
      AnswerOption(label: "Gesundheit und Körperpflege", value: 9),
      AnswerOption(label: "Tiere und Pflanzen", value: 10),
      AnswerOption(label: "ausbildungsvorbereitende Maßnahmen (z.B. BVB, BVJ, BBW)", value: 11),
    ]),
    // Logik: Hier weiter mit soz_7
    QuestionnaireQuestion(questionId: "soz_6_1_text", text: "Was „sonstiges“?", type: AnswerFieldType.TEXT, options: {"keyboard": "text", "validation": "text"}),
    QuestionnaireQuestion(
        questionId: "soz_7",
        text: "Seit wie vielen Jahren stehen Sie im Berufsleben?",
        type: AnswerFieldType.NUMBER_PICKER,
        options: {"min": 0, "max": 53, "step": null, "trailing": "Jahr(e)", "messageAsFirstElement": true}),

    // # Bei soz_7 vielleicht nicht nur int zulassen sondern double? z.B. "4,5" Jahre...
    QuestionnaireQuestion(
        questionId: "soz_8",
        text: "Welche berufliche Tätigkeit üben Sie derzeit hauptsächlich aus bzw. als was waren Sie zuletzt beschäftigt, wenn Sie zurzeit nicht erwerbstätig sind?",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "Angestellte*r", value: 1),
          AnswerOption(label: "Arbeiter*in", value: 2),
          AnswerOption(label: "Beamtin/Beamter, auch Anwärter*in", value: 3),
          AnswerOption(label: "Landwirt*in im Haupterwerb", value: 4),
          AnswerOption(label: "Selbständig erwerbstätig und ich habe Mitarbeiter*innen", value: 5),
          AnswerOption(label: "Selbständig erwerbstätig ohne Mitarbeiter*innen oder ich beschäftige ausschließlich mithelfende Familienangehörige", value: 6),
          AnswerOption(label: "Mithelfende*r Familienangehörige*r, unbezahlt", value: 7),
          AnswerOption(label: "Auszubildende*r, auch Praktikant*in, Volontär*in", value: 8),
          AnswerOption(label: "Ich leiste ein freiwilliges soziales Jahr, Bundesfreiwilligendienst oder freiwilligen Wehrdienst", value: 9),
        ]),
    // Logik: wenn "Ich war noch nie berufstätig" dann zu soz_11 springen
    QuestionnaireQuestion(questionId: "soz_8_text", text: "Wie heißt ihre derzeitige Tätigkeit?", type: AnswerFieldType.TEXT, options: {"keyboard": "text", "validation": "text"}),

    QuestionnaireQuestion(questionId: "soz_8_2", text: "Sind Sie in einem Betrieb tätig?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Ja, in einem kleinen Betrieb (unter 50 Mitarbeiter*innen)", value: 1),
      AnswerOption(label: "Ja, in einem mittleren Betrieb (zwischen 51 und 250 Mitarbeiter*innen)", value: 3),
      AnswerOption(label: "Ja, in einem großen Betrieb (mehr als 251 Mitarbeiter*innen)", value: 4),
      AnswerOption(label: "Nein", value: 5),
    ]),

    QuestionnaireQuestion(questionId: "soz_9", text: "Welcher Branche/Welchem Wirtschaftszweig gehört der Betrieb, in dem Sie arbeiten, an?", type: AnswerFieldType.RADIOGROUP, answerOptions: [
      AnswerOption(label: "Bauwirtschaft", value: 1),
      AnswerOption(label: "Beherbergungs- und Gaststättengewerbe", value: 2),
      AnswerOption(label: "Bergbau und Gewinnung von Steinen und Erden", value: 3),
      AnswerOption(label: "Energie- und Wasserversorgung", value: 4),
      AnswerOption(label: "Erbringung von sonstigen öffentlichen und persönlichen Dienstleistungen", value: 5),
      AnswerOption(label: "Erziehung und Unterricht", value: 6),
      AnswerOption(label: "Exterritoriale Organisationen und Körperschaften", value: 7),
      AnswerOption(label: "Fischerei und Fischzucht", value: 8),
      AnswerOption(label: "Gesundheits-, Veterinär- und Sozialwesen", value: 9),
      AnswerOption(label: "Grundstücks- und Wohnungswesen", value: 10),
      AnswerOption(label: "Unternehmensbezogene Dienstleistungen", value: 11),
      AnswerOption(label: "Handel, Instandhaltung und Reparatur von Kraftfahrzeugen und Gebrauchsgütern", value: 12),
      AnswerOption(label: "Herstellung, Be- und Verarbeitung von Waren", isGroupTitle: true),
      AnswerOption(label: "Büromaschinen, DV-Geräte, DV-Einrichtungen", value: 13),
      AnswerOption(label: "Elektrotechnik, Feinmechanik, Optik", value: 14),
      AnswerOption(label: "Chemische Erzeugnisse", value: 15),
      AnswerOption(label: "Fahrzeugbau", value: 16),
      AnswerOption(label: "Glas, Glaswaren und Keramik, Verarbeitung von Steinen und Erden", value: 17),
      AnswerOption(label: "Gummi- und Kunststoffwaren", value: 18),
      AnswerOption(label: "Holz und Holzwaren, Kork- und Flechtwaren (ohne Möbel)", value: 19),
      AnswerOption(label: "Kokerei und Mineralölverarbeitung sowie Spalt- und Brutstoffe", value: 20),
      AnswerOption(label: "Leder und Lederwaren", value: 21),
      AnswerOption(label: "Maschinenbau", value: 22),
      AnswerOption(label: "Metallerzeugung, -bearbeitung und -erzeugnisse", value: 23),
      AnswerOption(label: "Möbel, Schmuck, Musikinstrumente, Sportgeräte, Spielwaren", value: 24),
      AnswerOption(label: "Nahrungs- und Genussmittel", value: 25),
      AnswerOption(label: "Papier und Pappe, Verlags- und Druckerzeugnisse", value: 26),
      AnswerOption(label: "Textilien und Bekleidung", value: 27),
      AnswerOption(label: "Weitere", isGroupTitle: true),
      AnswerOption(label: "Hochschule", value: 28),
      AnswerOption(label: "Kreditinstitute und Versicherungen (ohne Sozialversicherung)", value: 29),
      AnswerOption(label: "Land- und Forstwirtschaft", value: 30),
      AnswerOption(label: "Öffentliche Verwaltung, Verteidigung, Sozialversicherung", value: 31),
      AnswerOption(label: "Private Haushalte", value: 32),
      AnswerOption(label: "Verkehr und Nachrichtenübermittlung", value: 33),
    ]),

    QuestionnaireQuestion(
        questionId: "soz_11",
        text: "Wie hoch ist Ihr Haushalts-Netto-Einkommen? (Rechnen Sie hier alle Einkünfte und Einnahmen Ihres Haushalts zusammen, inkl. Kindergeld, Mieteinnahmen, etc.)",
        type: AnswerFieldType.RADIOGROUP,
        answerOptions: [
          AnswerOption(label: "300 bis 499 €/Monat", value: 1),
          AnswerOption(label: "500 bis 999 €/Monat", value: 2),
          AnswerOption(label: "1.000 bis 1.499 €/Monat", value: 3),
          AnswerOption(label: "1.500 bis 1.999 €/Monat", value: 4),
          AnswerOption(label: "2.000 bis 2.499 €/Monat", value: 5),
          AnswerOption(label: "2.500 bis 2.999 €/Monat", value: 6),
          AnswerOption(label: "3.000 bis 4.999 €/Monat", value: 7),
          AnswerOption(label: "5.000 bis 7.499 €/Monat", value: 8),
          AnswerOption(label: "7.500 bis 9.999 €/Monat", value: 9),
          AnswerOption(label: "10.000 und mehr €/Monat", value: 10),
        ]),
    // the question "soz_ende" has logic in the finishSurvey function of the MandatoryScreeningSetScreen class
    QuestionnaireQuestion(
      questionId: "soz_ende",
      text:
          "Vielen Dank, dass Sie die vielen Fragen beantwortet haben. Wenn Sie noch mehr über sich erfahren möchten, finden Sie hier weitere Fragen zum Erleben der aktuellen COVID-19 Pandemie und zu Aspekten Ihrer Persönlichkeit. Am Schluss erhalten Sie Ihr eigenes Persönlichkeitsprofil. Haben Sie Lust?",
      type: AnswerFieldType.RADIOGROUP,
      answerOptions: [
        AnswerOption(label: "Ja", value: 1),
        AnswerOption(label: "Nein", value: 0),
      ],
    )
  ];

  @override
  bool skipItem(List<QuestionnaireAnswer> answers, int currentItemIndex) {
    if (answers[currentItemIndex].questionId == "soz_4_text") {
      if (this.getAnswerById(answers, "soz_4")?.answerValues["index"] != 7) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_5_text") {
      if (this.getAnswerById(answers, "soz_5")?.answerValues["index"] != 5) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_6_1") {
      if (this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 2 && this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 3) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_6_1_1") {
      if (this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 2 && this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 3) return true;
      if (this.getAnswerById(answers, "soz_6_1")?.answerValues["index"] != 0) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_6_1_text") {
      if (this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 2 && this.getAnswerById(answers, "soz_6")?.answerValues["index"] != 3) return true;
      if (this.getAnswerById(answers, "soz_6_1")?.answerValues["index"] != 8) return true;
    }

    if (answers[currentItemIndex].questionId == "soz_8_2") {
      if (this.getAnswerById(answers, "soz_6")?.answerValues["index"] == 3) return true;
    }

    return false;
  }
}
