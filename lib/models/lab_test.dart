import 'package:cloud_firestore/cloud_firestore.dart';

class LabTest {
  final String? id;
  final String name;
  final String method;
  final String equipment;
  final String imageUrlOrPath;
  final String reagent;
  final List<ProcedureStep> procedure;
  final List<String> appratus;

  LabTest({
    this.id,
    required this.name,
    required this.method,
    required this.equipment,
    required this.procedure,
    required this.imageUrlOrPath,
    required this.appratus,
    required this.reagent,
  });

  factory LabTest.fromJson(QueryDocumentSnapshot<Object?> json) => LabTest(
    id: json.id,
    name: json['name'] as String,
    method: json['method'] as String,
    equipment: json['equipment'] as String,
    procedure: List.from(
      json['procedure'] as List<dynamic>,
    ).map((e) => ProcedureStep.fromJson(e as Map<String, dynamic>)).toList(),
    imageUrlOrPath: json['imageUrlOrPath'] as String,
    reagent: json['reagent'] as String,
    appratus: List<String>.from(json['appratus'] as List<dynamic>),
  );

  factory LabTest.classExample() => LabTest(
    name: "Sulfur UV",
    method: "D5453",
    equipment: "UV equip",
    procedure: [
      ProcedureStep.classExample(
        step: 1,
        description: "startup Machine.",
        equipment: "UV Machine",
        keypoint: "Task manager->Method->Startup Machine->Add task ->Run.",
      ),
      ProcedureStep.classExample(
        step: 2,
        description: "Create Sample Group",
        keypoint:
            "Sample Manager->Add Sample Group->Name it->Choose Cave->Choose Sample Number->Input Sample ID->Input Sample Densitu ->Save.",
      ),
      ProcedureStep(
        step: 3,
        description: 'Flow-meter',
        volume: 12,
        keypoint:
            "Flow-meter->Check Flow of Oxygen(300 +- 10%) -> Argon(100+-10%) -> Total Air(500+-10%)",
      ),
      ProcedureStep.classExample(
        step: 4,
        description: "Run BLK",
        volume: 1,
        unit: "ml",
        equipment: "UV Machine",
        tool: "Syringe",
        reagent: "ISO-OCTANE",
        keypoint:
            "Get Rid of all bubble -> Presss Start -> Inject the Syirnge -> Press the popup Ok-> Wait for the result -> Save.",
      ),
      ProcedureStep.classExample(
        step: 5,
        description: "Duplicate BLK  for 3 times until the result < 1 million.",
      ),
      ProcedureStep.classExample(
        step: 6,
        description:
            "Run QC Sample. Different Concentration goes to different Curve.",
      ),
      ProcedureStep.classExample(
        step: 7,
        description: "When QC passed, run BLK again",
        keypoint: ", make sure the result < 1 million.",
      ),
      ProcedureStep.classExample(
        step: 8,
        description: "Add Sample * 3 duplicates.",
        keypoint: "Mean number is the result.",
      ),
      ProcedureStep.classExample(
        step: 9,
        description: "Run BLK Again.",
        keypoint: "Make sure the result < 1 million.",
      ),
      ProcedureStep.classExample(
        step: 10,
        description: 'Add Standby Job-> Run Machine',
      ),
    ],

    imageUrlOrPath: "images/default.jpg",
    reagent: "ISO-OCTANE",
    appratus: ["UV Machine", "Cuvette"],
  );

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'name': name,
    'method': method,
    'equipment': equipment,
    'procedure': procedure.map((e) => e.toJson()).toList(),
    'imageUrlOrPath': imageUrlOrPath,
    'reagent': reagent,
    'appratus': appratus,
  };
}

class ProcedureStep {
  final int step;
  final String description;
  final String? equipment;
  final int? volume;
  final String? unit;

  final String? tool;
  final String? reagent;
  final String? keypoint;

  ProcedureStep({
    required this.step,
    required this.description,
    this.equipment,
    this.volume,
    this.tool,
    this.reagent,
    this.keypoint,
    this.unit,
  });

  factory ProcedureStep.fromJson(Map<String, dynamic> json) => ProcedureStep(
    step: json['step'] as int,
    volume: json['volume'] as int,
    description: json['description'] as String,
    equipment: json['equipment'] as String?,
    tool: json['tool'] as String?,
    reagent: json['reagent'] as String?,
    keypoint: json['keypoint'] as String?,
    unit: json['unit'] as String?,
  );

  factory ProcedureStep.classExample({
    required int step,
    required String description,
    int? volume,
    String? equipment,
    String? tool,
    String? unit,
    String? reagent,
    String? keypoint,
  }) => ProcedureStep(
    step: step,
    description: description,
    equipment: equipment,
    volume: volume ?? 0,
    unit: unit,
    tool: tool,
    reagent: reagent,
    keypoint: keypoint,
  );

  Map<String, dynamic> toJson() => {
    'step': step,
    'description': description,
    'equipment': equipment,
    'volume': volume,
    'unit': unit,
    'tool': tool,
    'reagent': reagent,
    'keypoint': keypoint,
  };
}
