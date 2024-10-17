import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'commande_state.dart';

class CommandeCubit extends Cubit<CommandeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CommandeCubit() : super(CommandeInitial());

  void fetchCommandesWithStatusZero(int status) async {
    try {
      emit(CommandeLoading());

      // Fetch commandes from Firestore where status equals the passed parameter
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('commande')
          .where('status', isEqualTo: status)
          .get();

      // Extract the documents as a list of maps
      List<Map<String, dynamic>> commandes = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the map
        return data;
      }).toList();

      emit(CommandeLoaded(commandes));
    } catch (e) {
      emit(CommandeError('Failed to fetch commandes: $e'));
    }
  }

  // Method to update the status of a commande
 Future<void> updateCommandeStatus(String id, int currentStatus) async {
  try {
    emit(CommandeStatusUpdateLoading());
    // Increment the status by 1
    int newStatus = currentStatus + 1;
    await _firestore.collection('commande').doc(id).update({'status': newStatus});

    // Fetch the updated commande
    DocumentSnapshot<Map<String, dynamic>> updatedCommandeSnapshot =
        await _firestore.collection('commande').doc(id).get();

    Map<String, dynamic> updatedCommande = updatedCommandeSnapshot.data()!;
    updatedCommande['id'] = updatedCommandeSnapshot.id;

    emit(CommandeStatusUpdateLoaded(updatedCommande));
  } catch (e) {
    emit(CommandeStatusUpdateError('Failed to update commande status: $e'));
  }
}

}
