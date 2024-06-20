return {
	{
		"CRAG666/code_runner.nvim",
		enabled = false,
		opts = {
			filetype = {
				c = "cd $dir && clang $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt && rm $fileNameWithoutExt",
				java = "cd $dir && java -cp . $fileName",
				python = "python3 -u",
				typescript = "deno run",
				rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
				javascript = "cd $dir && node $fileName",
				ruby = "cd $dir && ruby $fileName",
			},
			project = {
				["~/codes/projects/java/chat-app/"] = {
					name = "chat-app",
					description = "test",
					file_name = "src/main/java/code/server.java",
					command = "mvn clean package && java -cp target/chat-app-0.1.jar: code.App",
				},
			},
			startinsert = true,
		},
		keys = {
			{ "<leader>r", "<cmd>RunCode<CR>", mode = { "n" }, desc = "RunCode" },
		},
	},
}
