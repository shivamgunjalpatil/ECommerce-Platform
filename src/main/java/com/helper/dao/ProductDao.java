package com.helper.dao;

import com.helper.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import jakarta.persistence.criteria.*;

public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product) {
        boolean f = false;
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(product);
            tx.commit();
            session.close();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }

    public List<Product> getAllProducts() {
        Session session = this.factory.openSession();
        Query<Product> query = session.createQuery("FROM Product", Product.class);
        List<Product> productList = query.list();
        session.close();
        return productList;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        Session session = this.factory.openSession();
        Query<Product> query = session.createQuery("FROM Product WHERE category.categoryId = :categoryId", Product.class);
        query.setParameter("categoryId", categoryId);
        List<Product> productList = query.list();
        session.close();
        return productList;
    }

    public Product getProductById(int productId) {
        Product product = null;
        try {
            Session session = this.factory.openSession();
            product = session.get(Product.class, productId);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    // Get total number of products
    public int getProductCount() {
        Session session = this.factory.openSession();
        try {
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Long> cq = cb.createQuery(Long.class);
            Root<Product> root = cq.from(Product.class);
            cq.select(cb.count(root));
            Long count = session.createQuery(cq).getSingleResult();
            return count != null ? count.intValue() : 0;
        } finally {
            session.close();
        }
    }
}