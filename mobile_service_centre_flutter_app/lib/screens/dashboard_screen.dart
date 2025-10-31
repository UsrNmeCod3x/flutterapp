import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final ApiService _apiService = ApiService();

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CustomersScreen(),
    JobsScreen(),
    StockScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Service Centre'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Mobile Service Centre Management System',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Use the navigation bar at the bottom to access different sections of the application.',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total Customers',
                  value: '0',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  title: 'Active Jobs',
                  value: '0',
                  icon: Icons.work,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Staff Members',
                  value: '0',
                  icon: Icons.person,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  title: 'Low Stock Items',
                  value: '0',
                  icon: Icons.inventory,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                SizedBox(width: 10),
                Text(title),
              ],
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _customers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  void _loadCustomers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final customers = await _apiService.getCustomers();
      setState(() {
        _customers = customers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading customers: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _loadCustomers,
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
            ],
          ),
          SizedBox(height: 20),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _customers.length,
                    itemBuilder: (context, index) {
                      final customer = _customers[index];
                      return Card(
                        child: ListTile(
                          title: Text(customer['name']),
                          subtitle: Text(
                              '${customer['phone']}\n${customer['email']}'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _jobs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  void _loadJobs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final jobs = await _apiService.getJobs();
      setState(() {
        _jobs = jobs;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading jobs: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jobs',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _loadJobs,
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
            ],
          ),
          SizedBox(height: 20),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      final job = _jobs[index];
                      return Card(
                        child: ListTile(
                          title: Text('${job['brand']} ${job['model']}'),
                          subtitle: Text(
                              'Issue: ${job['issue']}\nStatus: ${job['status']}'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class StockScreen extends StatefulWidget {
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _stockItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStock();
  }

  void _loadStock() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final stockItems = await _apiService.getStock();
      setState(() {
        _stockItems = stockItems;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading stock: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stock',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _loadStock,
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
              ),
            ],
          ),
          SizedBox(height: 20),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _stockItems.length,
                    itemBuilder: (context, index) {
                      final item = _stockItems[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['name']),
                          subtitle: Text(
                              'Category: ${item['category']}\nQuantity: ${item['quantity']}'),
                          trailing: Text('\$${item['unitPrice']}'),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'User Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Text('Name'),
                    subtitle: Text('John Doe'),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text('john@example.com'),
                  ),
                  ListTile(
                    title: Text('Role'),
                    subtitle: Text('Administrator'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}