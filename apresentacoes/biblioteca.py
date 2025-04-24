import mysql.connector
from mysql.connector import Error

# Configurações do banco de dados (substitua com suas credenciais)
config = {
    'host': 'localhost',
    'user': 'root',
    'password': '54321',
    'database': 'biblioteca'
}

def listar_livros_por_genero(genero):
    try:
        conn = mysql.connector.connect(**config)
        cursor = conn.cursor()

        # Chamando a stored procedure
        cursor.callproc('ListarLivrosPorGenero', [genero])
        
        # Capturando os resultados
        for result in cursor.stored_results():
            livros = result.fetchall()
            if livros:
                print(f"\nLivros do gênero '{genero}':")
                for livro in livros:
                    print(f"- Título: {livro[0]}, Ano: {livro[1]}")
            else:
                print(f"Nenhum livro encontrado no gênero '{genero}'")
                
    except Error as e:
        print(f"Erro ao acessar o banco: {e}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

def inserir_livro(titulo, ano, genero):
    try:
        conn = mysql.connector.connect(**config)
        cursor = conn.cursor()

        # Chamando a stored procedure
        cursor.callproc('InserirLivro', [titulo, ano, genero])
        conn.commit()
        print("\nLivro inserido com sucesso!")
        
    except Error as e:
        conn.rollback()
        print(f"Erro ao inserir livro: {e}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

# Menu interativo
if __name__ == "__main__":
    while True:
        print("\n--- Sistema Biblioteca ---")
        print("1. Listar livros por gênero")
        print("2. Inserir novo livro")
        print("3. Sair")
        
        opcao = input("Escolha uma opção: ")
        
        if opcao == '1':
            genero = input("Digite o gênero para pesquisa: ")
            listar_livros_por_genero(genero)
            
        elif opcao == '2':
            titulo = input("Título do livro: ")
            ano = int(input("Ano de publicação: "))
            genero = input("Gênero: ")
            inserir_livro(titulo, ano, genero)
            
        elif opcao == '3':
            print("Saindo do sistema...")
            break
            
        else:
            print("Opção inválida!")