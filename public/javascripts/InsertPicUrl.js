/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


  function insertImage(img_url) {
    window.tinyMCE.execCommand('mceInsertContent', false, "<br/><img src='"+img_url+"'/>");
  }