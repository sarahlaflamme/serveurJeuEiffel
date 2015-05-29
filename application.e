note
	description : "Serveur enregistrant les scores du jeu dans un fichier texte"
	author: "Sarah Laflamme"
	date: "$Date$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialisation

	make
		-- Constructeur du serveur.
		do
			set_stop(false)
			create fichier.make_with_name ("Fichiers/scores.txt")

			afficher_scores

			create thread_serveur.make (fichier)
			thread_serveur.launch

			from
			until stop
			loop
				io.read_character
				if io.last_character ='0' then
					set_stop(true)
				end
			end

			thread_serveur.stop_thread
			thread_serveur.join



		end


feature -- Attributs

	fichier: PLAIN_TEXT_FILE
		--

	thread_serveur: THREAD_SERVEUR
		--

	stop: BOOLEAN
		-- Indique que le serveur doit se fermer


feature -- Setters

	set_stop(a_stop: BOOLEAN)
		-- Assigne la valeur à stop
		do
			stop := a_stop
		end

feature -- Méthodes

	afficher_scores
		-- Lit et affiche à l'écran les scores enregistrés dans le fichier
		do
			print("LISTES DES SCORES%N")
			print("-----------------%N%N")
			fichier.open_read

			from
			until
				fichier.end_of_file
			loop
				fichier.read_line
				io.put_string (fichier.last_string + "%N")

			end

			fichier.close

		end

	quit
			-- Methode à appeler (avec un agent) pour arrêter la boucle principale
		do
			stop:=true
		end

end
