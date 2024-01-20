def lambda_handler(event, context):
    try:
        import pkg_resources

        pkgs = "\n".join(
            sorted(
                [f"{d.project_name}=={d.version}" for d in pkg_resources.working_set]
            )
        )
    except ImportError:
        import subprocess

        pkgs = subprocess.run(["pip3", "freeze"], capture_output=True, text=True).stdout

    return {"statusCode": 200, "body": pkgs}
