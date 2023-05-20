import 'package:flutter/material.dart';

import '../../configs/themes/app_color.dart';
import '../../configs/themes/ui_parameters.dart';
import '../custom_icon_button.dart';
import '../custom_search_bar.dart';
import './custom_list_tile.dart';

class CustomList extends StatefulWidget {
  const CustomList({
    super.key,
    required this.height,
    this.onDelete,
    this.deleteIcon = Icons.delete,
    this.deleteMessage = 'Delete Selected',
    this.searchMessage = 'Search',
    required this.searchBy,
    required this.onSelectedIndexUpdate,
    required this.getTile,
    required this.list,
    this.width = 250,
  });

  final double height;
  final double width;
  final IconData deleteIcon;
  final List<dynamic> list;
  final Widget Function(dynamic) getTile;
  final List<int> Function(String) searchBy;
  final Function(List<int>)? onDelete;
  final String deleteMessage;
  final String searchMessage;
  final Function(List<int>) onSelectedIndexUpdate;

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  bool selection = false;
  Set<int> selectedIndexes = <int>{};
  List<int> filteredIndex = [];
  final searchController = TextEditingController();
  List<dynamic> list = [];
  @override
  void initState() {
    list = widget.list;
    super.initState();
  }

  setSelectionState(bool state) {
    if (state == true && widget.onDelete == null) {
      return;
    }
    setState(() {
      selection = state;
      if (selection == false) {
        removeAllIndex();
      }
    });
  }

  void addIndex(int index) {
    if (!selection) {
      selectedIndexes.clear();
    }
    if (selectedIndexes.add(index) == true) {
      setState(() {});
    }

    widget.onSelectedIndexUpdate(selectedIndexes.toList());
  }

  void removeIndex(int index) {
    if (selectedIndexes.remove(index) == true) {
      widget.onSelectedIndexUpdate(selectedIndexes.toList());

      setState(() {});
    }
  }

  void removeAllIndex() {
    if (selectedIndexes.isNotEmpty) {
      selectedIndexes.clear();
      widget.onSelectedIndexUpdate(selectedIndexes.toList());

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    setValues();
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(color: Colors.white, boxShadow: kShadow),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          kHeightSpace,
          getSearchArea(),
          kHeightSpace,
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) => filteredIndex.contains(index)
                  ? getListTile(index)
                  : const SizedBox.shrink(),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }

  void setValues() {
    final searchText = searchController.text;

    if (searchText == '') {
      for (int i = 0; i < list.length; i++) {
        filteredIndex.add(i);
      }
    } else {
      filteredIndex = widget.searchBy(searchText);
    }
  }

  Column getListTile(int index) {
    bool isSelected = selectedIndexes.contains(index);

    return Column(
      children: [
        CustomListTile(
            index: index,
            isSelected: isSelected,
            selection: selection,
            onLongPress: () => setSelectionState(!selection),
            onTap: () {
              isSelected ? removeIndex(index) : addIndex(index);
            },
            tile: widget.getTile(list[index])),
        const Divider(height: 1),
      ],
    );
  }

  SizedBox getSearchArea() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          kHalfWidthSpace,
          searchBar(),
          selectedIndexes.isNotEmpty && widget.onDelete != null
              ? deleteButton()
              : kHalfWidthSpace,
        ],
      ),
    );
  }

  CustomIconButton deleteButton() {
    return CustomIconButton(
      onTap: deleteSelected,
      message: widget.deleteMessage,
      icon: widget.deleteIcon,
      color: Colors.redAccent,
    );
  }

  void deleteSelected() {
    // call Delete On Outside;
    widget.onDelete!(selectedIndexes.toList());
    setState(() {
      filteredIndex.clear();
      selectedIndexes.clear();
    });
  }

  Widget searchBar() {
    return Expanded(
      child: CustomSearchBar(
        hintText: widget.searchMessage,
        controller: searchController,
        onChange: () {
          setState(() {});
        },
      ),
    );
  }
}
