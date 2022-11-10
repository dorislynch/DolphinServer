using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Dolphin.Server.RNDolphinServer
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNDolphinServerModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNDolphinServerModule"/>.
        /// </summary>
        internal RNDolphinServerModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNDolphinServer";
            }
        }
    }
}
