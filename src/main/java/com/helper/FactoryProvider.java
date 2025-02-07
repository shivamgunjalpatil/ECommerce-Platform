package com.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {
	private static SessionFactory sessionFactory;

	public static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			try {

				sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
				System.out.println("SessionFactory created successfully!");
			} catch (Exception e) {
				System.err.println("SessionFactory creation failed: " + e);
				throw new ExceptionInInitializerError(e);
			}
		}
		return sessionFactory;

	}

}
