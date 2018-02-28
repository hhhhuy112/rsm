CKEDITOR.editorConfig = function(config){
   config.toolbar = [
      {name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFormWord', '-', 'Undo', 'Redo']},
      {name: 'editing', items: ['Scayt']},
      {name: 'mini', items: ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript"]},
      {name: 'insert', items: ['Image', 'Table', 'HorizontaRule', 'SpecialChar']},
      {name: 'tool', items: ['Maximize']}
   ];
};
