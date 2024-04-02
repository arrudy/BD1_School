
function format_date( date )
{
    if (typeof date == "string")
    {
        date = new Date(date);
    }

    var year = date.getFullYear();
    var month = (1 + date.getMonth()).toString();
    month = month.length > 1 ? month : '0' + month;

    var day = date.getDate().toString();
    day = day.length > 1 ? day : '0' + day;

    return year+'-'+month+'-'+day;
}






/*
function fn_search()
 {
     var lname = document.getElementById("lname").value ;
     document.getElementById("data").style.display = "none" ;
     var json_data = "{\"lname\":\"" + lname + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=searchRec" ;
     resp = function(response) {
        document.getElementById("art_content").innerHTML = response ; 
        document.getElementById("art_header").innerHTML = 'Lista znalezionych rekordow';
      }
      xmlhttpPost (url, msg, resp) ;                          
}  */

function fn_search_class()
 {
     var klasa = document.getElementById("class").value ;
     var json_data = "{\"class\":\"" + klasa + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=searchClass" ;
     resp = function(response) {
        document.getElementById("response").innerHTML = response ; 
        document.getElementById("art_header").innerHTML = 'Lista znalezionych rekordow';
      }
      xmlhttpPost (url, msg, resp) ;                          
}  




/*
function fn_search_note(id)
 {
     //document.getElementById("data").style.display = "none" ;
     var json_data = "{\"osoba_id\":\"" + id + "\"}" ;
     var msg = "data=" + encodeURIComponent(json_data) ;
     var url = "index.php?sub=Baza&action=listNote" ;
     resp = function(response) {
        document.getElementById("art_content").innerHTML = response ; 
        document.getElementById("art_header").innerHTML = 'Lista uwag';
      }
      xmlhttpPost (url, msg, resp) ;                          
}  

*/


  
function xmlhttpPost(strURL, mess, respFunc) {
    var xmlHttpReq = false;
    var self = this;
    // Mozilla/Safari
    if (window.XMLHttpRequest) {
        self.xmlHttpReq = new XMLHttpRequest();
    }
    // IE
    else if (window.ActiveXObject) {
        self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
    }
    self.xmlHttpReq.onreadystatechange = function() {
    if(self.xmlHttpReq.readyState == 4){
        // alert ( self.xmlHttpReq.status ) ;
        if ( self.xmlHttpReq.status == 200 ) {    
           // document.getElementById("data").innerHTML = http_request.responseText;
          respFunc( self.xmlHttpReq.responseText ) ;
        }
        else if ( self.xmlHttpReq.status == 401 ) {
           window.location.reload() ;
        } 
      }
    }
    self.xmlHttpReq.open('POST', strURL);
    self.xmlHttpReq.setRequestHeader("X-Requested-With","XMLHttpRequest");
    self.xmlHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded; ");
    //self.xmlHttpReq.setRequestHeader("Content-length", mess.length);
    self.xmlHttpReq.send(mess);        
}