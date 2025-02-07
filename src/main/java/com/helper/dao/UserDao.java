package com.helper.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import com.helper.entities.User;
import jakarta.persistence.criteria.*;

public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    public List<User> getAllUsers() {
        Session session = this.factory.openSession();
        List<User> userList = session.createQuery("from User").list();
        session.close();
        return userList;
    }


    // Get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try (Session session = this.factory.openSession()) {  // Ensures session is closed properly
            String query = "FROM User WHERE userEmail = :e AND userPassword = :p";
            Query<User> q = session.createQuery(query, User.class);
            q.setParameter("e", email);
            q.setParameter("p", password);

            user = q.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get total number of users
    public int getUserCount() {
        Session session = this.factory.openSession();
        try {
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Long> cq = cb.createQuery(Long.class);
            Root<User> root = cq.from(User.class);
            cq.select(cb.count(root));
            Long count = session.createQuery(cq).getSingleResult();
            return count != null ? count.intValue() : 0;
        } finally {
            session.close();
        }
    }
}