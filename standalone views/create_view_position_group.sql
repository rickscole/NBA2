SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[position_group] as 

select 'G' as position, 'G' as position_group 
union select 'PG', 'G'
union select 'SG', 'G'
union select 'F', 'F'
union select 'SF', 'F'
union select 'PF', 'F'
union select 'C', 'C'
GO
