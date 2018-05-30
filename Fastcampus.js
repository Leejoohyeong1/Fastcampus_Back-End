  const express = require('express');
  const app = express();
  app.use(express.static('files'));
  var multer  = require('multer');
  var mysql = require('mysql');
  var fs      = require('fs');
  var request = require('request');



  app.use('/profileImage', express.static('./profileImage'));
  app.use('/diaryimage', express.static('./diaryimage'));

  var connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '1234',
    database: 'Fastcampus',

  });

  var UserCreateAPP = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'diary/')
    },
    filename: function (req, file, cb) {
        console.log(req.body);
        var Token = req.body.Token
        var authority = req.body.authority
        var Contents = req.body.Contents
        var img = req.body.img

        //Token authority Contents                        Date_created =now()
      var query = connection.query('INSERT INTO Userinfo SET ? ', req.body, function (error, results, fields) {
        if (error){
          console.log(error);
          console.log(query.sql);


        } 
        console.log(results.insertId);
          file.uploadedFile = {
            name: results.insertId,
            ext: file.mimetype.split('/')[1]
          };
          cb(null, file.uploadedFile.name + '.png')
      });
    }
  });

  var APPlogin = multer({ storage: UserCreateAPP })

  var DiaryCreate = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'diaryimage/')
    },
    filename: function (req, file, cb) {
        console.log(req.body);
        console.log("DiaryCreate");
        var uid = req.body.uid;
        var authority = req.body.authority;
        var Contents = req.body.Contents;

      var query = connection.query('INSERT INTO DiaryList (Token, authority, Contents, Date_created) values ( ? , ? , ? ,NOW()) ON DUPLICATE KEY UPDATE Token = Token and Date_created = Date_created ',
      [uid,authority,Contents], function (error, results, fields) {
        console.log(query.sql)
        if (error){
          console.log(error);
          console.log(query.sql);

        } 
        console.log(results.insertId);
          file.uploadedFile = {
            name: results.insertId,
            ext: file.mimetype.split('/')[1]
          };
          cb(null, file.uploadedFile.name + '.png')



      });
    }
  });

  var DiaryCreateAdd = multer({ storage: DiaryCreate })

  var Modify = multer.diskStorage({
    

    destination: function (req, file, cb) {
      cb(null, 'diaryimage/')
    },
    filename: function (req, file, cb) {
      console.log("수정한다")
        console.log(req.body);
        var Contents = req.body.Contents;
        var authority = req.body.authority;
        var No = req.body.No;
        var uid = req.body.uid;

      var query = connection.query('UPDATE DiaryList SET Contents = ? ,authority = ? WHERE No = ? AND Token = ?',
      [Contents,authority,No,uid], function (error, results, fields) {
        console.log(query.sql)
        if (error){
          console.log(error);
          console.log(query.sql);
        } 
        console.log(No);
          file.uploadedFile = {
            name: No,
            ext: file.mimetype.split('/')[1]
          };
          cb(null, file.uploadedFile.name + '.png');
      });
    }
  });

  var DiaryModify = multer({ storage: Modify })

  app.post('/UserCreate/APP',APPlogin.single('image'), function(req, res) {
      res.setHeader('Content-Type', 'text/plain;charset=UTF-8');
      console.log("/UserCreate/APP");

      console.log(req.body);
  });
    
  app.post('/UserCreate/API', function(req, res) {
    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');
    console.log("=========================================================")

    var email = req.body.Email;
    var name = req.body.Name;
    var image = req.body.image;
    var uid = req.body.uid;
    var post  = {UserEmail: email, Name: name, Login_uid: uid };
    var query = connection.query('INSERT INTO Userinfo SET ? ON DUPLICATE KEY UPDATE Login_uid = Login_uid;', post, function (error, results, fields) {
      if (error){
        console.log(error);
      } 
      request.get({url: image, encoding: 'binary'}, function (err, response, body) {
        fs.writeFile("./profileImage/"+ results.insertId+".png", body, 'binary', function(err) {
          if(err){
            console.log(query.sql);
          }else{
            console.log(results);
          }
        }); 
      });
    });
  });

  app.post('/start', function(req, res) {
    console.log("/start");
    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');
    var uid = req.body.uid;
    console.log(uid);

    var query = connection.query('SELECT * FROM Userinfo where Login_uid = ? ',
    [uid], function (error, results, fields) {
      console.log(query.sql);
      if (error){
        console.log(error);
      } 

      res.json(results[0]);
    });
  });

  app.post('/friendList', function(req, res) {
    console.log("/friendList");
    var uid = req.body.uid;
    console.log(req.body)
    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');

    var query = connection.query("SELECT Userindex,UserEmail,Name,PushToken,Login_uid FROM Userinfo where Login_uid in (SELECT friendtoken FROM Groupinfo WHERE  mytoken = ? )",
    [uid], function (error, results, fields) {
      console.log( query.sql);
      if (error){
        console.log(error);
      } 
      console.log(results)
      res.json(results);
    });
    
  });

  app.post('/diaryCreate',DiaryCreateAdd.single('image'), function(req, res) {
    console.log("/diaryCreate");


    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');

    var uid = req.body.uid;
    var authority = req.body.authority;
    var Contents = req.body.Contents;


    if (req.file == undefined ) {
      var query = connection.query('INSERT INTO DiaryList (Token, authority, Contents, Date_created) values ( ? , ? , ? ,NOW()) ',
      [uid,authority,Contents], function (error, results, fields) {
        console.log( query.sql);
        if (error){
          console.log(error);
        } 
        console.log(results)
        res.json(results);
      });
    }


  });

  app.post('/diaryModify',DiaryModify.single('image'), function(req, res) {
    console.log("/diaryModify");
  

 

    if (req.file == undefined ) {
      var Contents = req.body.Contents;
      var authority = req.body.authority;
      var No = req.body.No;
      var uid = req.body.uid;

    var query = connection.query('UPDATE DiaryList SET Contents = ? ,authority = ? WHERE No = ? AND Token = ?',
    [Contents,authority,No,uid], function (error, results, fields) {
      console.log(query.sql)
      if (error){
        console.log(error);
        console.log(query.sql);
      } 
      console.log(No);
    });

    }else{
      console.log("파일이 있다")
    }



    var uid = req.body.uid;
    var No = req.body.No;


    console.log(uid)
    console.log(No)

    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');
  });




  app.post('/diaryList', function(req, res) {
    console.log("sss")
    var uid = req.body.uid;
    var M = req.body.month;
    var Y = req.body.year;
    console.log(req.body.uid);
    console.log("/diaryList");
    var sql = " SELECT Userinfo.Userindex , Userinfo.UserEmail, Userinfo.Name,Userinfo.Login_uid, DiaryList.No , DiaryList.authority, DiaryList.Contents, DATE_FORMAT(DiaryList.Date_created, '%Y-%m-%d') date";
        sql+= " FROM Userinfo";
        sql+= " INNER JOIN DiaryList ON Userinfo.Login_uid = DiaryList.Token where  YEAR(DiaryList.Date_created)  = ? and MONTH(DiaryList.Date_created) = ? and ";
        sql+= " ((Userinfo.Login_uid = ? ) or";
        sql+= " (Userinfo.Login_uid  IN (SELECT friendtoken FROM Groupinfo where mytoken = ? ) and authority = 2))";
        sql+= "  order by DiaryList.Date_created DESC ;";
    console.log(uid)
    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');

    var query = connection.query(sql, [Y,M,uid,uid], function (error, results, fields) {
      if (error){

        console.log(query.sql)
      }
      // console.log(results)
      res.json(results);
    });
  });

  app.post('/friendAdd', function(req, res) {
    var fruenduid = req.body.fruenduid;
    var myuid = req.body.myuid
    
    console.log(req.body.myuid);
    console.log("/diaryList");
    var sql = " INSERT INTO Groupinfo (mytoken,friendtoken) VALUES ";
        sql+= " ( ? , ? ),";
        sql+= " ( ? , ? ) ";
        

    res.setHeader('Content-Type', 'text/plain;charset=UTF-8');

    var query = connection.query(sql, [myuid,fruenduid,fruenduid,myuid], function (error, results, fields) {
      if (error){
        console.log("친구 추가 실패")
        res.end("친구 추가 실패");
      }else{
        console.log("친구 추기 성공")
        res.end("친구 추기 성공");
      }
    });
  });

  app.listen(3000, () => console.log('Example app listening on port 3000!'));
