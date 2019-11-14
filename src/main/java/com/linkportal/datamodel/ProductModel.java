package com.linkportal.datamodel;

import java.util.ArrayList;
import java.util.List;
import com.linkportal.datamodel.Product;

public class ProductModel {

	public Product find() {
		return new Product("p01", "name 1", 20);
	}

	public List<Product> findAll() {
		List<Product> products = new ArrayList<Product>();
		products.add(new Product("p01", "First Name", 20));
		products.add(new Product("p02", "Second Name", 21));
		products.add(new Product("p03", "Third Name", 22));
		return products;
	}

}
