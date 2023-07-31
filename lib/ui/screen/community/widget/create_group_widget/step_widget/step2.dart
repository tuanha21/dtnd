import 'package:flutter/material.dart';

class Step2CreateGroup extends StatefulWidget {
  const Step2CreateGroup({Key? key}) : super(key: key);

  @override
  State<Step2CreateGroup> createState() => _Step2CreateGroupState();
}

class _Step2CreateGroupState extends State<Step2CreateGroup> {
  final List<bool> _selectedStatesTruongPhai = List.generate(8, (_) => false);
  final List<bool> _selectedStatesNganh = List.generate(8, (_) => false);
  final List<bool> _selectedStatesChiaSeChuDe = List.generate(8, (_) => false);

  List<String> truongPhaiList = [
    "Đầu tư giá trị",
    "Đầu tư lướt sóng",
    "Đầu tư tăng trưởng",
    "Cổ tức",
    "Phân tích cơ bản",
    "Phân tích kỹ thuật",
    "Đầu tư DCA Trung bình giá",
  ];

  List<String> nganhList = [
    "Ngân hàng",
    "Chứng khoán",
    "Dầu khí",
    "Bất động sản",
    "Bán lẻ",
    "Điện nước",
    "Tài chính bảo hiểm",
  ];

  List<String> chiaSeChuDeList = [
    "Kiến thức",
    "Quản lý tài chính cá nhân",
    "Tin tức mỗi ngày",
    "Vui buồn đánh chứng",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Chọn tối đa từ 1 - 3 các chủ đề bạn sẽ chia sẻ trong nhóm nhé.",
            ),
            const SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildFilterSection("Trường phái đầu tư", truongPhaiList,
                      _selectedStatesTruongPhai, context),
                  _buildFilterSection(
                      "Ngành", nganhList, _selectedStatesNganh, context),
                  _buildFilterSection("Chia sẻ chủ đề", chiaSeChuDeList,
                      _selectedStatesChiaSeChuDe, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> itemList,
      List<bool> selectedStates, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 45,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return _buildFilterItem(index, itemList, selectedStates);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterItem(
      int index, List<String> itemList, List<bool> selectedStates) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedStates[index] = !selectedStates[index];
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    selectedStates[index] ? Colors.blue : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                itemList[index],
                style: TextStyle(
                  color: selectedStates[index] ? Colors.white : Colors.black,
                  fontSize: 12,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
