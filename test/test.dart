class _BookService3State extends State<BookService3> {
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');
  final _dayyFormatter = DateFormat('EEE');

// Define our current index!
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      dates.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              // set current index!
              currentindex = i;
            });
          },
          child: Container(
            height: height * 0.13,
            width: width * 0.2,
            decoration: BoxDecoration(
                color: currentindex == i ? Colors.white : Colors.blue, // Here we checked!
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _monthFormatter.format(date),
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'UbuntuRegular',
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: height * 0.002,
                  ),
                  Text(_dayFormatter.format(date),
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'UbuntuRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  SizedBox(
                    height: height * 0.002,
                  ),
                  Text(_dayyFormatter.format(date),
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'UbuntuRegular',
                          fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      )
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: dates.map((widget) => widget).toList(),
        ),
      ),
    );
  }
}