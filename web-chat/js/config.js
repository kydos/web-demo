// Generated by CoffeeScript 1.7.1
(function() {
  var root;

  root = this;

  root.dds = {};

  root.dds.runtime = {};

  dds.runtime.controllerPath = '/vortex/controller';

  dds.runtime.readerPrefixPath = '/vortex/reader';

  dds.runtime.writerPrefixPath = '/vortex/writer';

  dds.runtime.controllerURL = function(server) {
    return server + dds.runtime.controllerPath;
  };

  dds.runtime.readerPrefixURL = function(server) {
    return server + dds.runtime.readerPrefixPath;
  };

  dds.runtime.writerPrefixURL = function(server) {
    return server + dds.runtime.writerPrefixPath;
  };

}).call(this);
