// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:habits_now_app/core/constants.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../../../../core/utils.dart';
// import '../../calendar/events.dart';
// import '../model/task_model.dart';
// import '../provider/task_provider.dart';

// class TaskWidget extends StatelessWidget {
//   final Task task;

//   const TaskWidget({
//     Key? key,
//     required this.task,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Slidable(
//           actionPane: const SlidableDrawerActionPane(),
//           key: Key(task.id),
//           actions: [
//             IconSlideAction(
//               color: kDefaultDeleteButton,
//               caption: 'Deletar',
//               onTap: () {
//                 deleteTask(context, task);
//               },
//               icon: Icons.delete,
//             )
//           ],
//           child: buildTask(context),
//         ),
//       );

//   Widget buildTask(BuildContext context) {
//     return Container(
//       color: kDefaultAppcolor,
//       padding: kDefaultMargin,
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   task.title,
//                   style: kDefaultTitleStyle,
//                 ),
//                 if (task.description.isNotEmpty)
//                   Container(
//                     margin: kDefaultMargin,
//                     child: Text(
//                       task.description,
//                       style: kDefaultTextStyle,
//                     ),
//                   ),
//                 Container(
//                   margin: kDefaultMargin,
//                   child: Text(
//                     task.calendar,
//                     style: kDefaultTextStyle,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void deleteTask(BuildContext context, Task task) {
//     DateTime habitsDate = DateFormat.yMd("pt_BR").parseUTC(task.calendar);
//     kEvents[habitsDate]!.remove(task.evento);

//     final provider = Provider.of<TaskProvider>(context, listen: false);

//     provider.removeTask(task);

//     Utils.showSnackBar(context, 'Tarefa deletada!');
//   }
// }
