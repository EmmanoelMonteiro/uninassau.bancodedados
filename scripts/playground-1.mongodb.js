//CRIANDO UM BANCO E COLEÇÃO

use('biblioteca2');
//db.createCollection("livros")


//OPERAÇÃO CREATE (Inserir Documentos)
//Exemplo 1: Inserir um livro:
/*
db.livros.insertOne({
  titulo: "Dom Casmurro",
  autor: "Machado de Assis",
  ano: 1899,
  generos: ["Romance", "Ficção Brasileira"],
  disponivel: true
})
*/

/*Exemplo 2: Inserir múltiplos livros:*/

/*

db.livros.insertMany([
  {
    titulo: "1984",
    autor: "George Orwell",
    ano: 1949,
    paginas: 328
  },
  {
    titulo: "O Hobbit",
    autor: "J.R.R. Tolkien",
    ano: 1937,
    editora: "Allen & Unwin"
  }
])
*/

//OPERAÇÃO READ (Consultar Documentos)

/*Exemplo 1: Buscar todos os livros:*/

/*

db.livros.find()
*/

//Exemplo 2: Filtros com operadores:

/* Livros com mais de 300 páginas*/

/*
db.livros.find({ paginas: { $gt: 300 } })
*/

/*
use('biblioteca2');
db.livros.find({ 
  autor: "Machado de Assis", 
  disponivel: true 
})
*/

/*Exemplo 3: Projeção (selecionar campos):*/

/*
db.livros.find({}, { titulo: 1, autor: 1 })
*/

//OPERAÇÃO UPDATE (Atualizar Documentos)

/*Exemplo 1: Atualizar um campo:*/

/*
use('biblioteca2');
db.livros.updateOne(
  { titulo: "Dom Casmurro" },
  { $set: { editora: "Livraria Garnier" } }
)
*/

/*Exemplo 2: Atualizar múltiplos documentos:*/

/*
use('biblioteca2');
db.livros.updateMany(
  { ano: 1937 },
  { $set: { disponivel: false } }
)
*/

/*Exemplo 3: Operadores de atualização:*/

/*
db.livros.updateOne(
  { titulo: "1984" },
  { $push: { generos: "Distopia" } }
)
*/

//6.	OPERAÇÃO DELETE (Excluir Documentos)

/*Exemplo 1: Excluir um documento:*/

//db.livros.deleteOne({ titulo: "O Hobbit" })

/*Exemplo 2: Excluir múltiplos documentos:*/

//db.livros.deleteMany({ disponivel: false })

