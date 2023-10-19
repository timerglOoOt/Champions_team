package org.example;

import com.devskiller.jfairy.Fairy;
import com.devskiller.jfairy.producer.person.Person;

import java.sql.*;
import java.util.Random;

enum Position {
    RW ,
    LW,
    ST,
    RD,
    LD,
    CD,
    GK
}

public class Main {
    private static String URL = "jdbc:postgresql://localhost:5432/hockey";
    private static String USER = "postgres";
    private static String PASSWORD = "postgres";
    private static Position[] positions = Position.values();
    private static Random random = new Random();
    //language=sql
    private static final String INSERT_SQL =  "INSERT INTO players (name, surname, players_number," +
            " team_id, patronymic, birthday, job, nationality, phone_number, email, position) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    public static void main(String[] args) {
        try(Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            for (int i = 0; i < 1000; i++) {
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL);

                Person person = Fairy.create().person();
                preparedStatement.setString(1, person.getFirstName());
                preparedStatement.setString(2, person.getLastName());
                preparedStatement.setInt(3, random.nextInt(100));
                preparedStatement.setInt(4, 1);
                preparedStatement.setString(5, person.getMiddleName());
                preparedStatement.setDate(6, Date.valueOf(person.getDateOfBirth()));
                preparedStatement.setString(7, Fairy.create().company().getName());
                preparedStatement.setString(8, String.valueOf(person.getNationality()));
                preparedStatement.setString(9, person.getMobileTelephoneNumber());
                preparedStatement.setString(10, person.getEmail());
                preparedStatement.setString(11, String.valueOf(
                        positions[random.nextInt(positions.length - 1)]));

                try {
                    preparedStatement.executeUpdate();
                    preparedStatement.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}