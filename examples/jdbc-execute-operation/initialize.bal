import ballerina/sql;
import ballerinax/java.jdbc;

// Initializes the database as a prerequisite to the example.
function initialize() returns sql:Error? {
    jdbc:Client jdbcClient = check new ("jdbc:h2:file:./target/bbes/java_jdbc", "rootUser", "rootPass");

    //Creates a table in the database.
    _ = check jdbcClient->execute(`CREATE TABLE Customers(customerId INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY,
                                    firstName  VARCHAR(300), lastName  VARCHAR(300), registrationID INTEGER,
                                    creditLimit DOUBLE, country  VARCHAR(300), PRIMARY KEY (customerId))`);

    // Inserts data into the table. The result will have the `affectedRowCount`
    // and `lastInsertedId` with the auto-generated ID of the last row.
    _ = check jdbcClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID,creditLimit,country)
                                                    VALUES ('Peter', 'Stuart', 1, 5000.75, 'USA')`);
    _ = check jdbcClient->execute(`INSERT INTO Customers (firstName, lastName, registrationID,creditLimit,country)
                                                    VALUES ('Dan', 'Brown', 2, 10000, 'UK')`);

    check jdbcClient.close();
}
