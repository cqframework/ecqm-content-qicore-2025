library TestMedicationNotRequested

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000'

valueset "Medical Reason": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'

context Patient

define "Medication Not Requested":
  ["MedicationNotRequested"] MR
    where MR.reasonCode in "Medical Reason" // 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1007'

    