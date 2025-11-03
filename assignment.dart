// Abstract class demonstrating abstraction
abstract class Vehicle {
  // Private variables (encapsulation)
  String _make;
  String _model;
  int _year;
  
  // Constructor
  Vehicle(this._make, this._model, this._year);
  
  // Public getter methods (controlled access)
  String get make => _make;
  String get model => _model;
  int get year => _year;
  
  // Abstract method (to be implemented by subclasses)
  void startEngine();
  
  // Abstract method for calculating efficiency
  double calculateEfficiency();
  
  // Concrete method
  void displayInfo() {
    print('$_year $_make $_model');
  }
}

// Interface-like abstract class
abstract class Drivable {
  void drive();
}

// Superclass with encapsulation
class Car extends Vehicle implements Drivable {
  // Private variable for sensitive data
  double _mileage;
  bool _isStarted = false;
  
  // Constructor
  Car(String make, String model, int year, this._mileage) 
      : super(make, model, year);
  
  // Getter for mileage (controlled access)
  double get mileage => _mileage;
  
  // Setter with validation
  set mileage(double value) {
    if (value >= 0) {
      _mileage = value;
    } else {
      throw ArgumentError('Mileage cannot be negative');
    }
  }
  
  // Method overriding (polymorphism)
  @override
  void startEngine() {
    _isStarted = true;
    print('Car engine started with key ignition');
  }
  
  // Method overriding (polymorphism)
  @override
  double calculateEfficiency() {
    // Efficiency calculation for cars (miles per gallon estimation)
    return 30 - (_mileage / 10000);
  }
  
  // Implementation of drivable interface
  @override
  void drive() {
    if (_isStarted) {
      print('Car is driving smoothly on the road');
    } else {
      print('Please start the engine first');
    }
  }
  
  // Override display info with additional car details
  @override
  void displayInfo() {
    super.displayInfo();
    print('Mileage: $_mileage miles');
    print('Efficiency: ${calculateEfficiency().toStringAsFixed(2)} MPG');
  }
}

// Subclass demonstrating inheritance and polymorphism
class ElectricCar extends Car {
  // Private variables specific to electric cars
  double _batteryLevel;
  double _range;
  
  // Constructor
  ElectricCar(
    String make,
    String model,
    int year,
    double mileage,
    this._batteryLevel,
    this._range,
  ) : super(make, model, year, mileage);
  
  // Getters
  double get batteryLevel => _batteryLevel;
  double get range => _range;
  
  // Method overriding (polymorphism)
  @override
  void startEngine() {
    if (_batteryLevel > 0) {
      print('Electric car started silently with push-button ignition');
    } else {
      print('Cannot start - battery is dead');
    }
  }
  
  // Method overriding (polymorphism)
  @override
  double calculateEfficiency() {
    // Efficiency for electric cars (MPGe - miles per gallon equivalent)
    return (_range / 75) * 100; // Simplified calculation
  }
  
  // Override drive method
  @override
  void drive() {
    if (_batteryLevel > 0) {
      print('Electric car is driving quietly with no emissions');
      _batteryLevel -= 5; // Decrease battery level when driving
    } else {
      print('Cannot drive - battery is depleted');
    }
  }
  
  // Override display info with electric car details
  @override
  void displayInfo() {
    super.displayInfo();
    print('Battery Level: $_batteryLevel%');
    print('Range: $_range miles');
  }
}

// Another subclass demonstrating inheritance and polymorphism
class Motorcycle extends Vehicle implements Drivable {
  bool _isStarted = false;
  
  Motorcycle(String make, String model, int year) 
      : super(make, model, year);
  
  // Method overriding (polymorphism)
  @override
  void startEngine() {
    _isStarted = true;
    print('Motorcycle engine roars to life with kick start');
  }
  
  // Method overriding (polymorphism)
  @override
  double calculateEfficiency() {
    // Motorcycles typically have better fuel efficiency
    return 55.0;
  }
  
  // Implementation of drivable interface
  @override
  void drive() {
    if (_isStarted) {
      print('Motorcycle is weaving through traffic efficiently');
    } else {
      print('Please start the engine first');
    }
  }
  
  // Override display info with motorcycle details
  @override
  void displayInfo() {
    super.displayInfo();
    print('Type: Motorcycle');
    print('Efficiency: ${calculateEfficiency().toStringAsFixed(2)} MPG');
  }
}

// Main function to demonstrate OOP concepts
void main() {
  print('=== Demonstrating OOP Concepts ===\n');
  
  // Encapsulation example
  print('1. Encapsulation:');
  var car = Car('Toyota', 'Camry', 2022, 15000);
  print('Accessing public properties: ${car.make} ${car.model} ${car.year}');
  print('Accessing private data through getters: ${car.mileage} miles');
  car.displayInfo();
  
  try {
    car.mileage = -500; // This will throw an error
  } catch (e) {
    print('Error: $e');
  }
  
  print('\n---\n');
  
  // Inheritance, Polymorphism, and Abstraction example
  print('2. Inheritance, Polymorphism, and Abstraction:');
  
  // Creating instances of different vehicle types
  Vehicle car1 = Car('Honda', 'Accord', 2021, 20000);
  Vehicle electricCar = ElectricCar('Tesla', 'Model 3', 2023, 5000, 85, 300);
  Vehicle motorcycle = Motorcycle('Harley-Davidson', 'Street 750', 2020);
  
  // Polymorphism - same method calls, different behaviors
  List<Vehicle> vehicles = [car1, electricCar, motorcycle];
  
  for (var vehicle in vehicles) {
    print('\nVehicle Info:');
    vehicle.displayInfo();
    print('Starting engine:');
    vehicle.startEngine();
    
    // Type checking for drivable objects
    if (vehicle is Drivable) {
      print('Driving:');
      vehicle.drive();
    }
    
    print('Efficiency: ${vehicle.calculateEfficiency().toStringAsFixed(2)}');
  }
  
  print('\n---\n');
  
  // Demonstrating the specialized behavior of ElectricCar
  print('3. Specialized ElectricCar Features:');
  var tesla = electricCar as ElectricCar;
  print('Before driving:');
  tesla.displayInfo();
  
  print('\nDriving the electric car twice:');
  tesla.drive();
  tesla.drive();
  
  print('\nAfter driving:');
  tesla.displayInfo();
}