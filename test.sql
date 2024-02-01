CREATE table characters (
        id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50)
        );

CREATE TABLE debezium_signal (id VARCHAR(100) PRIMARY KEY, type VARCHAR(100) NOT NULL, data VARCHAR(2048) NULL);


INSERT INTO characters VALUES (1, 'luke', 'skywalker');
INSERT INTO characters VALUES (2, 'anakin', 'skywalker');
INSERT INTO characters VALUES (3, 'padmé', 'amidala');
SELECT * FROM characters;

INSERT INTO debezium_signal (id, type, data) VALUES ('ad-hoc', 'execute-snapshot', '{"data-collections": ["public.characters"],"type":"incremental"}');