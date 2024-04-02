   <!DOCTYPE html>
  
<html>
    <head>
   <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   <title>E-dziennik</title>
   <?php echo $css ; ?>   
   <script  src="js/baza.js"></script> 
</head>    <body>   
        <header><?php echo $title; ?></header>
<nav><?php echo $menu ; ?></nav>
        <section id="art_section">
          <header id="art_header"><?php echo $header; ?></header>
          <article id="art_content"><?php echo $content; ?></article> 
          

        </section>
        <footer>BD_2024 Arkadiusz Rudy</footer> 
    </body>
</html>