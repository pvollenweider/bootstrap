CKEDITOR.addTemplates('default',
    {
        // The name of the subfolder that contains the preview images of the templates.
        imagesPath:((typeof contextJsParameters != 'undefined') ? contextJsParameters.contextPath : '') + '/modules/bootstrap-module/icons/templates/',
        // Template definitions.
        templates:[
            {
                title:'',
                image:'alert_default.png',
                description:'',
                html:'<div class="alert">' +
                    '<button type="button" class="close" data-dismiss="alert">×</button>' +
                    '<strong>Warning!</strong> Best check yo self, you\'re not looking too good.' +
                    '</div>'
            },
            {
                title:'',
                image:'alert_error.png',
                description:'',
                html:'<div class="alert alert-error">' +
                    '<button type="button" class="close" data-dismiss="alert">×</button>' +
                    '<strong>Oh snap!</strong> Change a few things up and try submitting again.' +
                    '</div>'
            },
            {
                title:'',
                image:'alert_success.png',
                description:'',
                html:'<div class="alert alert-success">' +
                    '<button type="button" class="close" data-dismiss="alert">×</button>' +
                    '<strong>Well done!</strong> You successfully read this important alert message.' +
                    '</div>'
            },
            {
                title:'',
                image:'alert_info.png',
                description:'',
                html:'<div class="alert alert-info">' +
                    '<button type="button" class="close" data-dismiss="alert">×</button>' +
                    '<strong>Heads up!</strong> This alert needs your attention, but it\'s not super important.' +
                    '</div>'
            }
]
    });
