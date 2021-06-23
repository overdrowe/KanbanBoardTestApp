class KanbanCard {

  final int id;
  final int row;
  final int seqNum;
  final String text;

  KanbanCard({required this.id, required this.row, required this.seqNum, required this.text});

  factory KanbanCard.fromJson(Map<String, dynamic> json) {
    return KanbanCard(
      id: json['id'],
      row: int.parse(json['row']),
      seqNum: json['seq_num'],
      text: json['text'],
    );
  }
}