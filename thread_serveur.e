note
	description: "Summary description for {THREAD_SERVEUR}."
	author: "Sarah Laflamme"
	date: "$Date$"

class
	THREAD_SERVEUR

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialisation

	make(a_fichier: PLAIN_TEXT_FILE)
			-- Constructeur de `Current'.
		do
			make_thread
			set_stop(false)
			fichier := a_fichier
		end


feature -- Attributs


	port: INTEGER assign set_port
		-- Numéro du port à utiliser

	adresse_serveur: NETWORK_SOCKET_ADDRESS
		-- Adresse du serveur

	adresse_client: NETWORK_SOCKET_ADDRESS
		-- Adresse du client

	socket_serveur: NETWORK_STREAM_SOCKET
		-- Socket du serveur

	socket_client: NETWORK_STREAM_SOCKET
		-- Socket du client

	fichier: PLAIN_TEXT_FILE
		-- Le fichier dans lequel sont enregistrés les scores

	stop: BOOLEAN
		-- Indique que le serveur doit se fermer


feature -- Setters

	set_port(a_port: INTEGER)
		-- Assigne le numéro de port
		do
			port := a_port
		end

	set_stop(a_stop: BOOLEAN)
		-- Assigne la valeur à stop
		do
			stop := a_stop
		end


feature {NONE} -- Méthodes

	execute
			-- Exécution (thread) de `Current'
		do
			creer_socket_serveur

			from
			until
				stop
			loop
				socket_serveur.listen (1)
				if not stop then
					socket_serveur.accept
					socket_client := socket_serveur.accepted
					if socket_client = Void then
						io.put_string ("La connexion au client a échoué.%N")
					else
						adresse_client := socket_client.peer_address
						check
							adresse_client_attached: adresse_client /= Void
						end

						socket_client.read_line
						ajouter_nouveau_score(socket_client.last_string)
						io.put_string ("Nouveau score : " + socket_client.last_string + "%N")
						socket_client.close

					end
				end

			end
		end



	creer_socket_serveur
		-- Crée le socket du serveur
		do
			set_port(12345)
			--io.put_string ("Ouverture du serveur sur le port: "+ port.out +".%N")

			create socket_serveur.make_server_by_port (port)

			if not socket_serveur.is_bound then
				io.put_string ("Le port "+ port.out+" n'a pas pu être réservé.%N")
			else
				adresse_serveur := socket_serveur.address
				check
					addresse_serveur_attached: adresse_serveur /= Void
				end
			end
		end


	ajouter_nouveau_score(a_score: STRING)
		-- Ajoute un nouveau score au fichier
		do
			fichier.open_read_append
			fichier.put_string ("%N" + a_score)
			fichier.close
		end

feature -- Méthode Stop

	stop_thread
			-- Arrêter l'exécution du thread de `Current'
		do
			socket_serveur.close
			stop := true

		end

end
