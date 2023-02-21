SELECT * FROM person AS person("person.id", "person.name", "age", "gender", "address"),
    pizzeria AS pizzeria("pizzeria.id", "pizzeria.name", "rating")
ORDER by person."person.id", pizzeria."pizzeria.id";
