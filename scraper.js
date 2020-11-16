let fs = require('fs');
PDFParser = require("pdf2json");
var pdfreader = require('pdfreader');

pdfParser = new PDFParser();


// function parsePdf() {
//   pdfParser.on("pdfParser_dataError", errData => console.error(errData.parserError) );
//   pdfParser.on("pdfParser_dataReady", pdfData => {
//     fs.writeFile("./files/pdf.json", JSON.stringify(pdfData), function(err, result) {
//       if(err) console.log('error', err)
//     });
//   });

//   pdfParser.loadPDF("./files/para02.pdf");
// }

// function parsePdf() {
//   pdfParser.on("pdfParser_dataError", errData => console.error(errData.parserError) );
//   pdfParser.on("pdfParser_dataReady", pdfData => {
//     fs.writeFile("./files/fields.json", JSON.stringify(pdfData), function(err, result) {
//       if(err) console.log('error', err)
//       //pdfParser.getRawTextContent();
//       JSON.stringify(pdfParser.getAllFieldsTypes());
//     });
//   });

//   pdfParser.loadPDF("./files/para02.pdf");
// }

new PdfReader().parseFileItems("para05.pdf", function (err, item) {
  if (err) callback(err);
  else if (!item) callback();
  else if (item.text) console.log(item.text);
});


parsePdf();