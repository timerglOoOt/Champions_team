package ru.itis.oris;

import com.devskiller.jfairy.Fairy;
import com.devskiller.jfairy.producer.person.Person;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.Period;
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

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres";
    private static final String USER = "postgres";
    private static final String PASSWORD = "1234";

    private static final String sqlInsert = "INSERT INTO players (name, surname, players_number," +
            " team_id, patronymic, birth, profession, nationality, phone, email, position) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public static void main(String[] args) {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            Random random = new Random();
            for (int i = 0; i < 1000; i++) {
                Fairy fairy = Fairy.create();
                Person person = Fairy.create().person();

                PreparedStatement preparedStatement = connection.prepareStatement(sqlInsert);
                preparedStatement.setString(1, person.getFirstName()); // name
                preparedStatement.setString(2, person.getLastName()); // surname
                preparedStatement.setInt(3, (int) (Math.random() * (99 - 1) + 1)); // players_number
                preparedStatement.setInt(4, 1); // team_id
                preparedStatement.setString(5, person.getMiddleName()); // patronymic
                preparedStatement.setDate(6, Date.valueOf(person.getDateOfBirth())); // birth
                preparedStatement.setString(7, fairy.company().getName()); // profession
                preparedStatement.setString(8, String.valueOf(person.getNationality())); // nationality
                preparedStatement.setString(9, person.getMobileTelephoneNumber()); // phone
                preparedStatement.setString(10, "1" + person.getEmail()); // email
                preparedStatement.setString(11, Position.values()
                        [random.nextInt(Position.values().length)].toString()); // position

                try {
                    preparedStatement.executeUpdate();
                    preparedStatement.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
}