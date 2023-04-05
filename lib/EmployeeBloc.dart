// Todo: imports

// Todo: List of Employees
// Todo: Stream of controllers

// Todo: Stream Sink getter

// Todo: Constructor - add data; listen to changes

// Todo: Core Functions

// Todo: dispose

// imports
import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  // sink to add in pipe
  // stream to get data from pipe
  // by pipe i mean data flow

  // list of employees
  final List<Employee> _employeeList = [
    Employee(1, "Employee One", 1000.0),
    Employee(2, "Employee Two", 2000.0),
    Employee(3, "Employee Three", 3000.0),
    Employee(4, "Employee Four", 4000.0),
    Employee(5, "Employee Five", 5000.0),
    Employee(6, "Employee six", 6000.0),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  // stream of controllers
  // for inc and dec
  final _employeeSalaryIncreamentStreamController =
      StreamController<Employee>();
  final _employeeSalaryDecreamentStreamController =
      StreamController<Employee>();

  // stream sink getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncreamentStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecreamentStreamController.sink;

  // constructor - add data; listen to changes
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncreamentStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecreamentStreamController.stream.listen(_decrementSalary);
  }

  // core functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * (40 / 100);
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  // dispose
  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * (40 / 100);
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncreamentStreamController.close();
    _employeeSalaryDecreamentStreamController.close();
    _employeeListStreamController.close();
  }
}
