(function($, undefined) {

  if (typeof FormData === 'undefined') return;

  // Register a prefilter that checks whether the `iframe` option is set, and
  // switches to the iframe transport if it is `true`.
  $.ajaxPrefilter(function(options, origOptions, jqXHR) {
    if (options.formdata) return "formdata";
  });

  // Register an iframe transport, independent of requested data type. It will
  // only activate when the "files" option has been set to a non-empty list of
  // enabled file inputs.
  $.ajaxTransport("formdata", function(options, origOptions, jqXHR) {
    var form = null,
        xhr = new XMLHttpRequest(),
        formData = new FormData(),
        files = $(options.files).filter(":file:enabled");

    options.dataTypes.shift();

    if (files.length === 0) return;
    // Determine the form the file fields belong to, and make sure they all
    // actually belong to the same form.
    files.each(function() {
      if (form !== null && this.form !== form) {
        jQuery.error("All file fields must belong to the same form");
      }
      form = this.form;
    });
    form = $(form);

    // Add passed-in data to the FormData object
    // Note that the data must not be serialized (options.processData = false)
    if (typeof(options.data) === "string" && options.data.length > 0) {
      jQuery.error("data must not be serialized");
    }
    $.each(options.data || {}, function(name, value) {
      if ($.isPlainObject(value)) {
        name = value.name;
        value = value.value;
      }
      formData.append(name,value);
    });
    files.each(function() {
      var name = this.name;
      $.each(this.files,function(){
        formData.append(name,this)
      })
    })

    // Borrowed straight from the JQuery source
    // Provides a way of specifying the accepted data type similar to HTTP_ACCEPTS
    accepts = options.dataTypes[ 0 ] && options.accepts[ options.dataTypes[0] ] ?
      options.accepts[ options.dataTypes[0] ] + ( options.dataTypes[ 0 ] !== "*" ? ", */*; q=0.01" : "" ) :
      options.accepts[ "*" ]

    return {

      // The `send` function is called by jQuery when the request should be
      // sent.
      send: function(headers, completeCallback) {
        xhr.open('POST',options.url,true);
        xhr.setRequestHeader('Accept',accepts);
        xhr.setRequestHeader('X-Requested-With','FormData');
        xhr.onreadystatechange = function(e) {
          if (xhr.readyState !== 4) return;
          var status = xhr.status,
              statusText = xhr.statusText.replace(/^\d+ +/,''),
              responses = { text: xhr.responseText },
              headers = xhr.getAllResponseHeaders();
          completeCallback(status, statusText, responses, headers);
        };
        if (typeof xhr.upload !== 'undefined') xhr.upload.onprogress = function(e) {
          var progEvent = $.Event('ajax:progress.remotipart');
          $.extend(progEvent,e)
          form.trigger(progEvent);
        }
        else form.trigger('ajax:progress:notsupported.remotipart');
        xhr.send(formData);
      },

      // The `abort` function is called by jQuery when the request should be
      // aborted.
      abort: function() {
        xhr.abort();
      }
    };
  });

})(jQuery);