# Marking checklist

| Feature | What to show |
| --- | --- |
| **1.1 Describe Datasets** ★ | Open About and the README. Explain the three CSV extracts, the selected fields, and the source IDs used to connect the data. |
| 1.2 Database ERD | Show the diagram on About and identify both foreign keys. |
| 1.3 AR Models | Show the three migration files and the three models. |
| **1.4 At least 1 model Association** ★ | Open Charizard and follow either elemental type link. |
| 1.5 Model Associations | Explain the Pokémon and elemental type one-to-many links to the join model, plus the many-to-many association used in browsing and search. |
| 1.6 Validations | Open each model. Point out identifier presence and uniqueness, positive source IDs and measurements, and valid and unique type slots. |
| 1.7 Data Sources | Run `ruby bin/rails db:seed`. Show the three original CSV files and the two encounter/map extracts. The base catalog has 386 rows, plus 72 locations and 1,399 encounter combinations. |
| 2.1 About Page | Open About. |
| 2.2 Menu | Show Pokémon, Types, and About on the shared header. |
| **3.1 Collection Navigation** ★ | Open the Pokédex and browse the collection. |
| 3.2 Member Pages | Open a Pokémon and show its name, number, measurements, and base experience. |
| 3.3 Multi-model Data on Member Pages | On Charizard, point out the Fire and Flying links and explain where they come from. |
| 3.4 Hierarchical Collection Navigation | Open Charizard → Flying → Pidgey → Flying. |
| 3.5 Pagination | On the Pokédex, click Next and Previous. Select Poison and repeat to show the filter is preserved. |
| 3.6 Mapping | Open Pikachu and show the highlights and named encounters on the Kanto map. Ask the instructor whether imported in-game grid coordinates qualify for this feature. |
| **4.1 Simple Search** ★ | Search for `char` to see Charmander, Charmeleon, and Charizard. |
| 4.2 Hierarchical Search | Search for `char` with Flying selected to see just Charizard. |
| **5.1 Valid HTML** ★ | Use the Nu HTML Checker on pages saved from the running app or submit their HTML source. Include the collection, detail, type, About, and empty-result states. |
| 5.2 ERB Conditional | Search for a name that does not exist and show the corresponding `if` in the index template. |
| 5.3 Bootstrap Grid | Resize the collection and inspect its Bootstrap row and column classes. |
| **6.1 GIT and GitHub** ★ | After connecting your GitHub repository, show `git remote -v` and the pushed `master` branch. |
| 6.2 20 GIT Commits | Show `git rev-list --count HEAD` and `git log --oneline`. |

The instructor confirms credit during marking.
