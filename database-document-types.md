# General
participant

# For app flow
app-state

# For questionnaires and feedback
survey-state
questionnaire-state
questionnaire-answer
questionnaire-results
aggregated-results

# for study part 2 (prevention, intervention and control group)
participant-schedule


if (doc.docType == 'oneWaySyncDoc') {
    return false
}

 || doc.docType == 'tracking-data'