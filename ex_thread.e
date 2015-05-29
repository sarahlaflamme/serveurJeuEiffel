note
	description: "Affiche un message à répétition dans un thread secondaire"
	author: "Louis Marchand"
	date: "2015, Febuary 18"
	revision: "1.0"

class
	EX_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make (chaine: STRING)
			-- Initialisation de `Current' utilisant `chaine' comme message
			-- à afficher lors de l'exécution.
		do
			make_thread
			must_stop := false
			chaine_affiche := chaine
		end

feature -- Access

	stop_thread
			-- Arrêter l'exécution du thread de `Current'
		do
			must_stop := true
		end

feature {NONE} -- Thread methods

	execute
			-- Exécution (thread) de `Current'
		do
			from
			until
				must_stop
			loop
				io.put_string (chaine_affiche)
				io.output.flush
			end
		end

feature {NONE} -- Implementation

	must_stop: BOOLEAN
			-- Vrai si `Current' doit terminer son exécution

	chaine_affiche: STRING
			-- Chaine à afficher en boucle lors de l'exécution de `Current'

end
