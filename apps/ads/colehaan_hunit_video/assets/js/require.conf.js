require.config({
   // Initialize the application with the main application file
   //deps: ['main'],
   //baseUrl: '../../',
   paths: {
      // JavaScript folders
      canvas: '../../../../../../product2/framework/sources/src/com/adcade/canvas',
      dom: '../../../../../../product2/framework/sources/src/com/adcade/dom',
      test: '../../../../../../../../product2/framework/sources/src/com/adcade/test',
      app: '../../../../../../product2/framework/sources/src/com/adcade/app',
      gen: '../../../../../../product2/framework/sources/src/com/adcade/gen',
      libs: '../../../../../../product2/framework/sources/libs',

      // Libraries
      stats: '../../../../../../product2/framework/sources/libs/Stats',
      'Config': 'assets/js/Config',

      // Helpers
      'ProtocolHelper': '../../../../../../product2/framework/sources/src/com/adcade/gen/net/ProtocolHelper'
   },
});