const express = require("express");
const app = express();

const admin = require("firebase-admin");
const credentials = require("./key.json");

admin.initializeApp({
   credential: admin.credential.cert(credentials)
});

const db = admin.firestore();

app.use(express.json());

app.use(express.urlencoded({extended: true}));

const PORT = process.env.PORT || 8090;
app.listen(PORT, () => {
  console.log(`Server is nunning on PORT ${PORT}`);
});

// Import the filesystem module
const fs = require('fs');

app.get('/read/all', async (req, res) => {
  try {
  
      fs.mkdir('txtfiles', { recursive: true }, (err) => {
         if (err) throw err;
      });
      fs.mkdir('txtfiles/en', { recursive: true }, (err) => {
         if (err) throw err;
      });
      fs.mkdir('txtfiles/es', { recursive: true }, (err) => {
         if (err) throw err;
      });
      fs.mkdir('txtfiles/fr', { recursive: true }, (err) => {
         if (err) throw err;
      });
      fs.mkdir('txtfiles/ja', { recursive: true }, (err) => {
         if (err) throw err;
      });
      fs.mkdir('txtfiles/unknown', { recursive: true }, (err) => {
         if (err) throw err;
      });
      
      const confessionsRef = db.collection("Confessions").where("converteds1", "==", "false");
      let responseArr = [];
      let docname = "";
      let lcode = "";
      confessionsRef.get()
        .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
            console.log(doc.id, " => ", doc.data());
            docname = doc.id+doc.data().cdate+".txt";
            lcode = doc.data().clanguage;
            console.log("My docname is: ", docname);
            console.log("Language code is: ", lcode);
            responseArr.push(doc.data());
              if (lcode == "en"){
                  fs.writeFile('txtfiles/en/'+docname, doc.data().ctext, (err) => {
                  if (err)
                   console.log(err);
                  else {
                      console.log("File written successfully");
                      }
                 });
                 doc.ref.update({
                 converteds1: "true"
              });              
              } else if(lcode == "es"){
                 fs.writeFile('txtfiles/es/'+docname, doc.data().ctext, (err) => {
                  if (err)
                   console.log(err);
                  else {
                      console.log("File written successfully");
                      }
                 });
                 doc.ref.update({
                 converteds1: "true"
              }); 
              } else if(lcode == "fr"){
                 fs.writeFile('txtfiles/fr/'+docname, doc.data().ctext, (err) => {
                  if (err)
                   console.log(err);
                  else {
                      console.log("File written successfully");
                      }
                 });
                 doc.ref.update({
                 converteds1: "true"
              }); 
              } else if(lcode == "ja") {
                 fs.writeFile('txtfiles/ja/'+docname, doc.data().ctext, (err) => {
                  if (err)
                   console.log(err);
                  else {
                      console.log("File written successfully");
                      }
                 });
                 doc.ref.update({
                 converteds1: "true"
              });                  
              } else if (lcode == "unknown"){
                  fs.writeFile('txtfiles/unknown/'+docname, doc.data().ctext, (err) => {
                   if (err)
                   console.log(err);
                   else {
                      console.log("File written successfully");
                      }
                 });
                 doc.ref.update({
                 converteds1: "true"
              }); 
              } else {
                 console.log("Language code is not selected: ", lcode);
              }
        });
        res.send(responseArr);
    })
    .catch((error) => {
        console.log("Error getting documents: ", error);
    });
    
  } catch (error){
    console.log(error);
    res.send(error);
  }
});

app.get('/read/all2', async (req, res) => {
  try {
     const confessionsRef = db.collection("Confessions");
     const response = await confessionsRef.get();
     let responseArr = [];
     response.forEach(doc => {
        console.log(doc.id, '=>', doc.data());
        responseArr.push(doc.data());
  });
  console.log("Confessions length is: ", responseArr.length);
  res.send(responseArr);  
  } catch (error){
    res.send(error);
  }
});

app.get('/read/:id', async (req, res) => {
  try {
     const confessionsRef = db.collection("Confessions").doc(req.params.id);
     const response = await confessionsRef.get();
     console.log("Read one: ", response.data());
     res.send(response.data());     
  } catch (error){
    res.send(error);
  }
});
