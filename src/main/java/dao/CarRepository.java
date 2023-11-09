package dao;

import java.util.ArrayList;
import dto.Car;
import dto.Product;

public class CarRepository {
	private ArrayList<Car> listOfCars = new ArrayList<Car>();
	private static CarRepository instance = new CarRepository();
	
	public static CarRepository getInstance() {
		return instance;
	}

	public CarRepository() {
		Car car1 = new Car("192가1111", "현대 아반떼 AD 1.6 가솔린 터보", 1200);
		car1.setManufacturer("현대");
		car1.setCar_model("아반떼");
		car1.setCar_year(2015);
		car1.setCar_distance(80000);
		car1.setAccident_check("무사고");
		car1.setFuel("휘발유");
		car1.setCarkind("준중형");
		car1.setDealer_id("dbstndh12");
		car1.setDealer_phone("010-9339-7484");
		car1.setPic1("192가1111.png");

		Car car2 = new Car("192가1112", "현대 아반떼 CN7 인스퍼레이션", 2000);
		car2.setManufacturer("현대");
		car2.setCar_model("아반떼");
		car2.setCar_year(2021);
		car2.setCar_distance(30000);
		car2.setAccident_check("무사고");
		car2.setFuel("휘발유");
		car2.setCarkind("준중형");
		car2.setDealer_id("dbstndh12");
		car2.setDealer_phone("010-9339-7484");
		car2.setPic1("192가1112.png");

		Car car3 = new Car("192가1113", "기아 디 올 뉴 스포티지 2.0 디젤", 1800);
		car3.setManufacturer("기아");
		car3.setCar_model("스포티지");
		car3.setCar_year(2020);
		car3.setCar_distance(50000);
		car3.setAccident_check("무사고");
		car3.setFuel("경유");
		car3.setCarkind("SUV");
		car3.setDealer_id("dbstndh12");
		car3.setDealer_phone("010-9339-7484");
		car3.setPic1("192가1114.png");

		listOfCars.add(car1);
		listOfCars.add(car2);
		listOfCars.add(car3);
	}

	public ArrayList<Car> getAllCars() {
		return listOfCars;
	}
	
	public Car getCarById(String car_num) {
		Car carById = null;

		for (int i = 0; i < listOfCars.size(); i++) {
			Car car = listOfCars.get(i);
			if (car != null && car.getCar_num() != null && car.getCar_num().equals(car_num)) {
				carById = car;
				break;
			}
		}
		return carById;
	}
	
	public void addCar(Car car) {
		listOfCars.add(car);
	}
}
