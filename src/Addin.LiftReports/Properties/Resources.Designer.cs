﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.296
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Addin.LiftReports.Properties {
	using System;


	/// <summary>
	///   A strongly-typed resource class, for looking up localized strings, etc.
	/// </summary>
	// This class was auto-generated by the StronglyTypedResourceBuilder
	// class via a tool like ResGen or Visual Studio.
	// To add or remove a member, edit your .ResX file then rerun ResGen
	// with the /str option, or rebuild your VS project.
	[global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
	[global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
	[global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
	internal class Resources {

		private static global::System.Resources.ResourceManager resourceMan;

		private static global::System.Globalization.CultureInfo resourceCulture;

		[global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
		internal Resources() {
		}

		/// <summary>
		///   Returns the cached ResourceManager instance used by this class.
		/// </summary>
		[global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
		internal static global::System.Resources.ResourceManager ResourceManager {
			get {
				if (object.ReferenceEquals(resourceMan, null)) {
					global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Addin.LiftReports.Properties.Resources", typeof(Resources).Assembly);
					resourceMan = temp;
				}
				return resourceMan;
			}
		}

		/// <summary>
		///   Overrides the current thread's CurrentUICulture property for all
		///   resource lookups using this strongly typed resource class.
		/// </summary>
		[global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
		internal static global::System.Globalization.CultureInfo Culture {
			get {
				return resourceCulture;
			}
			set {
				resourceCulture = value;
			}
		}

		internal static System.Drawing.Bitmap image {
			get {
				object obj = ResourceManager.GetObject("image", resourceCulture);
				return ((System.Drawing.Bitmap)(obj));
			}
		}

		/// <summary>
		///   Looks up a localized string similar to &lt;!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD HTML 4.0 Transitional//EN&quot;&gt;
		///&lt;HTML&gt;
		///&lt;HEAD&gt;
		///	&lt;META HTTP-EQUIV=&quot;CONTENT-TYPE&quot; CONTENT=&quot;text/html; charset=utf-8&quot;&gt;
		///	&lt;TITLE&gt;&lt;/TITLE&gt;
		///	&lt;META NAME=&quot;GENERATOR&quot; CONTENT=&quot;OpenOffice.org 2.0  (Win32)&quot;&gt;
		///	&lt;META NAME=&quot;CREATED&quot; CONTENT=&quot;20070511;12454487&quot;&gt;
		///	&lt;META NAME=&quot;CHANGED&quot; CONTENT=&quot;20070514;8581762&quot;&gt;
		///	&lt;STYLE&gt;
		///	&lt;!--
		///		@page { size: 8.5in 11in; margin: 0.79in }
		///		P { margin-bottom: 0.08in }
		///		H1.heading-3-western { font-family: &quot;Times New Roman&quot;, serif; font-size: 14pt }
		/// [rest of string was truncated]&quot;;.
		/// </summary>
		internal static string reportTemplate {
			get {
				return ResourceManager.GetString("reportTemplate", resourceCulture);
			}
		}

		internal static System.Drawing.Bitmap WeSay {
			get {
				object obj = ResourceManager.GetObject("WeSay", resourceCulture);
				return ((System.Drawing.Bitmap)(obj));
			}
		}
	}
}
