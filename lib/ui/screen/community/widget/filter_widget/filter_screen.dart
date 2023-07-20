import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
    "Vàng",
    "Kinh doanh hàng hóa",
    "Ngành khác",
  ];

  List<String> chiaSeChuDeList = [
    "Kiến thức",
    "Quản lý tài chính cá nhân",
    "Tin tức mỗi ngày",
    "Vui buồn đánh chứng",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lọc theo"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildFilterSection("Trường phái đầu tư", truongPhaiList, _selectedStatesTruongPhai),
              _buildFilterSection("Ngành", nganhList, _selectedStatesNganh),
              _buildFilterSection("Chia sẻ chủ đề", chiaSeChuDeList, _selectedStatesChiaSeChuDe),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton('Làm mới'),
            _buildActionButton('Áp dụng'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> itemList, List<bool> selectedStates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 45,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
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

  Widget _buildFilterItem(int index, List<String> itemList, List<bool> selectedStates) {
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: selectedStates[index] ? Colors.blue : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                itemList[index],
                style: TextStyle(
                  color: selectedStates[index] ? Colors.white : Colors.black,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: (MediaQuery.of(context).size.width / 2) - 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }
}
