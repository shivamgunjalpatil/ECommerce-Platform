package com.helper.dao;

import com.helper.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import jakarta.persistence.criteria.*;

public class CategoryDao {
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    public int saveCategory(Category cat) {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId = (int) session.save(cat);
        tx.commit();
        session.close();
        return catId;
    }

    public List<Category> getCategories() {
        Session s = this.factory.openSession();
        Query query = s.createQuery("FROM Category");
        List<Category> list = query.list();
        return list;
    }

    public Category getCategoryById(int cid) {
        Category cat = null;
        try {
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }

    // Get total number of categories
    public int getCategoryCount() {
        Session session = this.factory.openSession();
        try {
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Long> cq = cb.createQuery(Long.class);
            Root<Category> root = cq.from(Category.class);
            cq.select(cb.count(root));
            Long count = session.createQuery(cq).getSingleResult();
            return count != null ? count.intValue() : 0;
        } finally {
            session.close();
        }
    }
}